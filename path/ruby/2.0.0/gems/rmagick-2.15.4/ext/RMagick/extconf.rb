lib_dir = File.expand_path('../../lib', File.dirname(__FILE__))
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)
require 'rubygems'
require 'mkmf'
require 'date'

module RMagick
  class Extconf
    require 'rmagick/version'
    RMAGICK_VERS = ::Magick::VERSION
    MIN_RUBY_VERS = ::Magick::MIN_RUBY_VERSION
    MIN_RUBY_VERS_NO = MIN_RUBY_VERS.tr('.','').to_i

    attr_reader :headers
    def initialize
      configure_compile_options
      assert_can_compile!
      configure_headers
    end

    def configured_compile_options
      {
        :magick_config => $magick_config,
        :pkg_config    => $pkg_config,
        :magick_version => $magick_version,
        :local_libs     => $LOCAL_LIBS,
        :cflags         => $CFLAGS,
        :cppflags       => $CPPFLAGS,
        :ldflags        => $LDFLAGS,
        :defs           => $defs,
        :config_h       => $config_h,
      }
    end

    def configure_headers
      #headers = %w{assert.h ctype.h errno.h float.h limits.h math.h stdarg.h stddef.h stdint.h stdio.h stdlib.h string.h time.h}
      @headers = %w{assert.h ctype.h stdio.h stdlib.h math.h time.h}
      headers << 'stdint.h' if have_header('stdint.h')  # defines uint64_t
      headers << 'sys/types.h' if have_header('sys/types.h')

      if have_header('wand/MagickWand.h')
        headers << 'wand/MagickWand.h'
      else
        exit_failure "\nCan't install RMagick #{RMAGICK_VERS}. Can't find MagickWand.h."
      end
    end

    def configure_compile_options
      # Magick-config is not available on Windows
      if RUBY_PLATFORM !~ /mswin|mingw/

        # Check for compiler. Extract first word so ENV['CC'] can be a program name with arguments.
        config = defined?(RbConfig) ? ::RbConfig : ::Config
        cc = (ENV['CC'] || config::CONFIG['CC'] || 'gcc').split(' ').first
        unless find_executable(cc)
          exit_failure "No C compiler found in ${ENV['PATH']}. See mkmf.log for details."
        end

        # ugly way to handle which config tool we're going to use...
        $magick_config = false
        $pkg_config = false

        # Check for Magick-config
        if find_executable('Magick-config') && !has_graphicsmagick_libmagick_dev_compat?
          $magick_config = true
          $magick_version = `Magick-config --version`[/^(\d+\.\d+\.\d+)/]
        elsif find_executable('pkg-config')
          $pkg_config = true
          $magick_version = `pkg-config MagickCore --modversion`[/^(\d+\.\d+\.\d+)/]
        else
          exit_failure "Can't install RMagick #{RMAGICK_VERS}. Can't find Magick-config or pkg-config in #{ENV['PATH']}\n"
        end

        check_multiple_imagemagick_versions
        check_partial_imagemagick_versions

        # Ensure minimum ImageMagick version
        # Check minimum ImageMagick version if possible
        checking_for("outdated ImageMagick version (<= #{Magick::MIN_IM_VERSION})") do
          Logging.message("Detected ImageMagick version: #{$magick_version}\n")

          if Gem::Version.new($magick_version) < Gem::Version.new(Magick::MIN_IM_VERSION)
            exit_failure "Can't install RMagick #{RMAGICK_VERS}. You must have ImageMagick #{Magick::MIN_IM_VERSION} or later.\n"
          end
        end

        # either set flags using Magick-config or pkg-config (new Debian default)
        if $magick_config
          # Save flags
          $CFLAGS     = ENV['CFLAGS'].to_s   + ' ' + `Magick-config --cflags`.chomp
          $CPPFLAGS   = ENV['CPPFLAGS'].to_s + ' ' + `Magick-config --cppflags`.chomp
          $LDFLAGS    = ENV['LDFLAGS'].to_s  + ' ' + `Magick-config --ldflags`.chomp
          $LOCAL_LIBS = ENV['LIBS'].to_s     + ' ' + `Magick-config --libs`.chomp
        end

        if $pkg_config
          # Save flags
          $CFLAGS     = ENV['CFLAGS'].to_s   + ' ' + `pkg-config --cflags MagickCore`.chomp
          $CPPFLAGS   = ENV['CPPFLAGS'].to_s + ' ' + `pkg-config --cflags MagickCore`.chomp
          $LDFLAGS    = ENV['LDFLAGS'].to_s  + ' ' + `pkg-config --libs MagickCore`.chomp
          $LOCAL_LIBS = ENV['LIBS'].to_s     + ' ' + `pkg-config --libs MagickCore`.chomp
        end

        if RUBY_PLATFORM =~ /darwin/ # osx
          set_archflags_for_osx
        end

      elsif RUBY_PLATFORM =~ /mingw/  # mingw

        `identify -version` =~ /Version: ImageMagick (\d+\.\d+\.\d+)-+\d+ /
        abort 'Unable to get ImageMagick version' unless $1
        $magick_version = $1
        unless have_library('CORE_RL_magick_')
          search_paths_for_library_for_mingw
        end
        have_library('X11')

      else  # mswin

        `identify -version` =~ /Version: ImageMagick (\d+\.\d+\.\d+)-+\d+ /
        abort 'Unable to get ImageMagick version' unless $1
        $magick_version = $1
        $CFLAGS = '-W3'
        $CPPFLAGS = %Q{-I"C:\\Program Files\\Microsoft Platform SDK for Windows Server 2003 R2\\Include" -I"C:\\Program Files\\ImageMagick-#{$magick_version}-Q8\\include"}
        # The /link option is required by the Makefile but causes warnings in the mkmf.log file.
        $LDFLAGS = %Q{/link /LIBPATH:"C:\\Program Files\\Microsoft Platform SDK for Windows Server 2003 R2\\Lib" /LIBPATH:"C:\\Program Files\\ImageMagick-#{$magick_version}-Q8\\lib" /LIBPATH:"C:\\ruby\\lib"}
        $LOCAL_LIBS = 'CORE_RL_magick_.lib'
        have_library('X11')

      end
    end

    # Test for a specific value in an enum type
    def have_enum_value(enum, value, headers=nil, &b)
      checking_for "#{enum}.#{value}" do
        if try_compile(<<"SRC", &b)
#{COMMON_HEADERS}
#{cpp_include(headers)}
/*top*/
int main() { #{enum} t = #{value}; t = t; return 0; }
SRC
          $defs.push(format('-DHAVE_ENUM_%s', value.upcase))
          true
        else
          false
        end
      end
    end

    # Test for multiple values of the same enum type
    def have_enum_values(enum, values, headers=nil, &b)
      values.each do |value|
        have_enum_value(enum, value, headers, &b)
      end
    end

    def has_graphicsmagick_libmagick_dev_compat?
      config_path = `which Magick-config`.chomp
      if File.exist?(config_path) &&
         File.symlink?(config_path) &&
         File.readlink(config_path) =~ /GraphicsMagick/
        msg = 'Found a graphicsmagick-libmagick-dev-compat installation.'
        Logging.message msg
        message msg+"\n"
        true
      else
        false
      end
    end

    def exit_failure(msg)
      Logging.message msg
      message msg+"\n"
      exit(1)
    end

    # Seems like lots of people have multiple versions of ImageMagick installed.
    def check_multiple_imagemagick_versions
      versions = []
      path = ENV['PATH'].split(File::PATH_SEPARATOR)
      path.each do |dir|
        file = File.join(dir, 'Magick-config')
        if File.executable? file
          vers = `#{file} --version`.chomp.strip
          prefix = `#{file} --prefix`.chomp.strip
          versions << [vers, prefix, dir]
        end
      end
      versions.uniq!
      if versions.size > 1
        msg = "\nWarning: Found more than one ImageMagick installation. This could cause problems at runtime.\n"
        versions.each do |vers, prefix, dir|
          msg << "         #{dir}/Magick-config reports version #{vers} is installed in #{prefix}\n"
        end
        msg << "Using #{versions[0][0]} from #{versions[0][1]}.\n\n"
        Logging.message msg
        message msg
      end
    end

    # Ubuntu (maybe other systems) comes with a partial installation of
    # ImageMagick in the prefix /usr (some libraries, no includes, and no
    # binaries). This causes problems when /usr/lib is in the path (e.g., using
    # the default Ruby installation).
    def check_partial_imagemagick_versions
      prefix = config_string('prefix') || ''
      matches = [
        prefix+'/lib/lib?agick*',
        prefix+'/include/ImageMagick',
        prefix+'/bin/Magick-config',
      ].map do |file_glob|
        Dir.glob(file_glob)
      end
      matches.delete_if { |arr| arr.empty? }
      if 0 < matches.length && matches.length < 3
        msg = "\nWarning: Found a partial ImageMagick installation. Your operating system likely has some built-in ImageMagick libraries but not all of ImageMagick. This will most likely cause problems at both compile and runtime.\nFound partial installation at: "+prefix+"\n"
        Logging.message msg
        message msg
      end
    end

    # issue #169
    # set ARCHFLAGS appropriately for OSX
    def set_archflags_for_osx
      archflags = []
      fullpath = `which convert`
      fileinfo = `file #{fullpath}`

      # default ARCHFLAGS
      archs = $ARCH_FLAG.scan(/-arch\s+(\S+)/).flatten

      archs.each do |arch|
        if fileinfo.include?(arch)
          archflags << "-arch #{arch}"
        end
      end

      if archflags.length != 0
        $ARCH_FLAG = archflags.join(' ')
      end
    end

    def search_paths_for_library_for_mingw
      msg = 'searching PATH for the ImageMagick library...'
      Logging.message msg
      message msg+"\n"

      found_lib = false

      paths = ENV['PATH'].split(File::PATH_SEPARATOR)
      paths.each do |dir|
        lib = File.join(dir, 'lib')
        lib_file = File.join(lib, 'CORE_RL_magick_.lib')
        if File.exist?(lib_file)
          $CPPFLAGS = %Q{-I"#{File.join(dir, 'include')}"}
          $LDFLAGS = %Q{-L"#{lib}"}
          found_lib = have_library('CORE_RL_magick_')
          break if found_lib
        end
      end

      unless found_lib
        exit_failure <<END_MINGW
Can't install RMagick #{RMAGICK_VERS}.
Can't find the ImageMagick library.
Retry with '--with-opt-dir' option.
Usage: gem install rmagick -- '--with-opt-dir=\"[path to ImageMagick]\"'
e.g.
  gem install rmagick -- '--with-opt-dir=\"C:\Program Files\ImageMagick-6.9.1-Q16\"'
END_MINGW
      end
    end

    def assert_can_compile!
      assert_not_windows!
      assert_minimum_ruby_version!
      assert_has_dev_libs!
    end

    def assert_not_windows!
      if RUBY_PLATFORM =~ /mswin/
        abort <<END_MSWIN
+----------------------------------------------------------------------------+
| This rmagick gem is for use only on Linux, BSD, OS X, and similar systems  |
| that have a gnu or similar toolchain installed. The rmagick-win32 gem is a |
| pre-compiled version of RMagick bundled with ImageMagick for use on        |
| Microsoft Windows systems. The rmagick-win32 gem is available on RubyForge.|
| See http://rmagick.rubyforge.org/install-faq.html for more information.    |
+----------------------------------------------------------------------------+
END_MSWIN
      end
    end

    def assert_minimum_ruby_version!
      unless checking_for("Ruby version >= #{MIN_RUBY_VERS}") do
        version = RUBY_VERSION.tr('.','').to_i
        version >= MIN_RUBY_VERS_NO
      end
        exit_failure "Can't install RMagick #{RMAGICK_VERS}. Ruby #{MIN_RUBY_VERS} or later required.\n"
      end
    end

    def assert_has_dev_libs!
      if RUBY_PLATFORM !~ /mswin|mingw/

        # check for pkg-config if Magick-config doesn't exist
        if $magick_config && `Magick-config --libs`[/\bl\s*(MagickCore|Magick)6?\b/]
        elsif $pkg_config && `pkg-config --libs MagickCore`[/\bl\s*(MagickCore|Magick)6?\b/]
        else
            exit_failure "Can't install RMagick #{RMAGICK_VERS}. " \
                   "Can't find the ImageMagick library or one of the dependent libraries. " \
                   "Check the mkmf.log file for more detailed information.\n"
        end
      end
    end

    def create_header_file
      have_func('snprintf', headers)
      ['AcquireImage',                   # 6.4.1
       'AffinityImage',                  # 6.4.3-6
       'AffinityImages',                 # 6.4.3-6
       'AutoGammaImageChannel',          # 6.5.5-1
       'AutoLevelImageChannel',          # 6.5.5-1
       'BlueShiftImage',                 # 6.5.4-3
       'ColorMatrixImage',               # 6.6.1-0
       'ConstituteComponentTerminus',    # 6.5.7-9
       'DeskewImage',                    # 6.4.2-5
       'DestroyConstitute',              # 6.5.7-9(deprecated)
       'EncipherImage',                  # 6.3.8-6
       'EqualizeImageChannel',           # 6.3.6-9
       'EvaluateImages',                 # 6.8.6-4
       'FloodfillPaintImage',            # 6.3.7
       'FunctionImageChannel',           # 6.4.8-8
       'GetAuthenticIndexQueue',         # 6.4.5-6
       'GetAuthenticPixels',             # 6.4.5-6
       'GetImageAlphaChannel',           # 6.3.9-2
       'GetMagickFeatures',              # 6.5.7-1
       'GetVirtualPixels',               # 6.4.5-6
       'LevelImageColors',               # 6.4.2
       'LevelColorsImageChannel',        # 6.5.6-4
       'LevelizeImageChannel',           # 6.4.2
       'LiquidRescaleImage',             # 6.3.8-2
       'MagickLibAddendum',              # 6.5.9-1
       'OpaquePaintImageChannel',        # 6.3.7-10
       'QueueAuthenticPixels',           # 6.4.5-6
       'RemapImage',                     # 6.4.4-0
       'RemapImages',                    # 6.4.4-0
       'RemoveImageArtifact',            # 6.3.6
       'RotationalBlurImage',            # 6.8.8-9
       'RotationalBlurImageChannel',     # 6.8.8-9
       'SelectiveBlurImageChannel',      # 6.5.0-3
       'SetImageAlphaChannel',           # 6.3.6-9
       'SetImageArtifact',               # 6.3.6
       'SetMagickMemoryMethods',         # 6.4.1
       'SparseColorImage',               # 6.3.6-?
       'StatisticImage',                 # 6.6.8-6
       'SyncAuthenticPixels',            # 6.4.5-6
       'TransformImageColorspace',       # 6.5.1
       'TransparentPaintImage',          # 6.3.7-10
       'TransparentPaintImageChroma'     # 6.4.5-6
      ].each do |func|
        have_func(func, headers)
      end

      checking_for('QueryMagickColorname() new signature')  do
        if try_compile(<<"SRC")
#{COMMON_HEADERS}
#{cpp_include(headers)}
/*top*/
int main() {
  MagickBooleanType okay;
  Image *image;
  MagickPixelPacket *color;
  char *name;
  ExceptionInfo *exception;
  okay = QueryMagickColorname(image, color, SVGCompliance, name, exception);
  return 0;
  }
SRC
          $defs.push('-DHAVE_NEW_QUERYMAGICKCOLORNAME')
          true
        else
          false
        end
      end

      have_struct_member('Image', 'type', headers)          # ???
      have_struct_member('DrawInfo', 'kerning', headers)    # 6.4.7-8
      have_struct_member('DrawInfo', 'interline_spacing', headers)   # 6.5.5-8
      have_struct_member('DrawInfo', 'interword_spacing', headers)   # 6.4.8-0
      have_type('DitherMethod', headers)                    # 6.4.2
      have_type('MagickFunction', headers)                  # 6.4.8-8
      have_type('ImageLayerMethod', headers)                # 6.3.6 replaces MagickLayerMethod
      have_type('long double', headers)
      #have_type("unsigned long long", headers)
      #have_type("uint64_t", headers)
      #have_type("__int64", headers)
      #have_type("uintmax_t", headers)
      #check_sizeof("unsigned long", headers)
      #check_sizeof("Image *", headers)

      have_enum_values('AlphaChannelType', ['CopyAlphaChannel',                    # 6.4.3-7
                                            'BackgroundAlphaChannel',              # 6.5.2-5
                                            'RemoveAlphaChannel'], headers)        # 6.7.5-1
      have_enum_values('CompositeOperator', ['BlurCompositeOp',                    # 6.5.3-7
                                             'DistortCompositeOp',                 # 6.5.3-10
                                             'LinearBurnCompositeOp',              # 6.5.4-3
                                             'LinearDodgeCompositeOp',             # 6.5.4-3
                                             'MathematicsCompositeOp',             # 6.5.4-3
                                             'PegtopLightCompositeOp',             # 6.5.4-3
                                             'PinLightCompositeOp',                # 6.5.4-3
                                             'VividLightCompositeOp'], headers)    # 6.5.4-3
      have_enum_values('CompressionType', ['DXT1Compression',                      # 6.3.9-3
                                           'DXT3Compression',                      # 6.3.9-3
                                           'DXT5Compression',                      # 6.3.9-3
                                           'ZipSCompression',                      # 6.5.5-4
                                           'PizCompression',                       # 6.5.5-4
                                           'Pxr24Compression',                     # 6.5.5-4
                                           'B44Compression',                       # 6.5.5-4
                                           'B44ACompression'], headers)            # 6.5.5-4

      have_enum_values('DistortImageMethod', ['BarrelDistortion',                  # 6.4.2-5
                                              'BarrelInverseDistortion',           # 6.4.3-8
                                              'BilinearForwardDistortion',         # 6.5.1-2
                                              'BilinearReverseDistortion',         # 6.5.1-2
                                              'DePolarDistortion',                 # 6.4.2-6
                                              'PolarDistortion',                   # 6.4.2-6
                                              'PolynomialDistortion',              # 6.4.2-4
                                              'ShepardsDistortion'], headers)      # 6.4.2-4
      have_enum_value('DitherMethod', 'NoDitherMethod', headers)                   # 6.4.3
      have_enum_values('FilterTypes', ['KaiserFilter',                             # 6.3.6
                                       'WelshFilter',                              # 6.3.6-4
                                       'ParzenFilter',                             # 6.3.6-4
                                       'LagrangeFilter',                           # 6.3.7-2
                                       'BohmanFilter',                             # 6.3.7-2
                                       'BartlettFilter',                           # 6.3.7-2
                                       'SentinelFilter'], headers)                 # 6.3.7-2
      have_enum_values('MagickEvaluateOperator', ['PowEvaluateOperator',           # 6.4.1-9
                                                  'LogEvaluateOperator',            # 6.4.2
                                                  'ThresholdEvaluateOperator',      # 6.4.3
                                                  'ThresholdBlackEvaluateOperator', # 6.4.3
                                                  'ThresholdWhiteEvaluateOperator', # 6.4.3
                                                  'GaussianNoiseEvaluateOperator',  # 6.4.3
                                                  'ImpulseNoiseEvaluateOperator',   # 6.4.3
                                                  'LaplacianNoiseEvaluateOperator', # 6.4.3
                                                  'MultiplicativeNoiseEvaluateOperator', # 6.4.3
                                                  'PoissonNoiseEvaluateOperator',   # 6.4.3
                                                  'UniformNoiseEvaluateOperator',   # 6.4.3
                                                  'CosineEvaluateOperator',         # 6.4.8-5
                                                  'SineEvaluateOperator',           # 6.4.8-5
                                                  'AddModulusEvaluateOperator'],    # 6.4.8-5
                       headers)
      have_enum_values('MagickFunction', ['ArcsinFunction',                        # 6.5.2-8
                                          'ArctanFunction',                        # 6.5.2-8
                                          'PolynomialFunction',                    # 6.4.8-8
                                          'SinusoidFunction'], headers)            # 6.4.8-8
      have_enum_values('ImageLayerMethod', ['FlattenLayer',                           # 6.3.6-2
                                            'MergeLayer',                             # 6.3.6
                                            'MosaicLayer',                            # 6.3.6-2
                                            'TrimBoundsLayer' ], headers)             # 6.4.3-8
      have_enum_values('VirtualPixelMethod', ['HorizontalTileVirtualPixelMethod',     # 6.4.2-6
                                              'VerticalTileVirtualPixelMethod',       # 6.4.2-6
                                              'HorizontalTileEdgeVirtualPixelMethod', # 6.5.0-1
                                              'VerticalTileEdgeVirtualPixelMethod',   # 6.5.0-1
                                              'CheckerTileVirtualPixelMethod'],       # 6.5.0-1
                       headers)

      # Now test Ruby 1.9.0 features.
      headers = ['ruby.h']
      if have_header('ruby/io.h')
        headers << 'ruby/io.h'
      else
        headers << 'rubyio.h'
      end

      have_func('rb_frame_this_func', headers)

      # Miscellaneous constants
      $defs.push("-DRUBY_VERSION_STRING=\"ruby #{RUBY_VERSION}\"")
      $defs.push("-DRMAGICK_VERSION_STRING=\"RMagick #{RMAGICK_VERS}\"")

      create_header
    end

    def create_makefile_file
      create_header_file
      # Prior to 1.8.5 mkmf duplicated the symbols on the command line and in the
      # extconf.h header. Suppress that behavior by removing the symbol array.
      $defs = []

      # Force re-compilation if the generated Makefile changed.
      $config_h = 'Makefile rmagick.h'

      create_makefile('RMagick2')
      print_summary
    end

    def print_summary
      summary = <<"END_SUMMARY"


#{'=' * 70}
#{DateTime.now.strftime('%a %d%b%y %T')}
This installation of RMagick #{RMAGICK_VERS} is configured for
Ruby #{RUBY_VERSION} (#{RUBY_PLATFORM}) and ImageMagick #{$magick_version}
#{'=' * 70}


END_SUMMARY

      Logging.message summary
      message summary
    end
  end
end

extconf = RMagick::Extconf.new
at_exit do
  msg = "Configured compile options: #{extconf.configured_compile_options}"
  Logging.message msg
  message msg+"\n"
end
extconf.create_makefile_file
