#!/usr/bin/env ruby -w

require 'rmagick'
require 'test/unit'
require 'test/unit/ui/console/testrunner' unless RUBY_VERSION[/^1\.9|^2/]

class Image1_UT < Test::Unit::TestCase
  FreezeError = RUBY_VERSION[/^1\.9|^2/] ? RuntimeError : TypeError

  def setup
    @img = Magick::Image.new(20, 20)
  end

  def test_read_inline
    img = Magick::Image.read(IMAGES_DIR+'/Button_0.gif').first
    blob = img.to_blob
    encoded = [blob].pack('m*')
    res = Magick::Image.read_inline(encoded)
    assert_instance_of(Array, res)
    assert_instance_of(Magick::Image, res[0])
    assert_equal(img, res[0])
  end

  def test_spaceship
    img0 = Magick::Image.read(IMAGES_DIR+'/Button_0.gif').first
    img1 = Magick::Image.read(IMAGES_DIR+'/Button_1.gif').first
    sig0 = img0.signature
    sig1 = img1.signature
    # since <=> is based on the signature, the images should
    # have the same relationship to each other as their
    # signatures have to each other.
    assert_equal(sig0 <=> sig1, img0 <=> img1)
    assert_equal(sig1 <=> sig0, img1 <=> img0)
    assert_equal(img0, img0)
    assert_not_equal(img0, img1)
  end

  def test_adaptive_blur
    assert_nothing_raised do
      res = @img.adaptive_blur
      assert_instance_of(Magick::Image, res)
    end
    assert_nothing_raised { @img.adaptive_blur(2) }
    assert_nothing_raised { @img.adaptive_blur(3, 2) }
    assert_raise(ArgumentError) { @img.adaptive_blur(3, 2, 2) }
  end

  def test_adaptive_blur_channel
    assert_nothing_raised do
      res = @img.adaptive_blur_channel
      assert_instance_of(Magick::Image, res)
    end
    assert_nothing_raised { @img.adaptive_blur_channel(2) }
    assert_nothing_raised { @img.adaptive_blur_channel(3, 2) }
    assert_nothing_raised { @img.adaptive_blur_channel(3, 2, Magick::RedChannel) }
    assert_nothing_raised { @img.adaptive_blur_channel(3, 2, Magick::RedChannel, Magick::BlueChannel) }
    assert_raise(ArgumentError) { @img.adaptive_blur(3, 2, 2) }
  end

  def test_adaptive_resize
    assert_nothing_raised do
      res = @img.adaptive_resize(10,10)
      assert_instance_of(Magick::Image, res)
    end
    assert_nothing_raised { @img.adaptive_resize(2) }
    assert_raise(ArgumentError) { @img.adaptive_resize(10,10,10) }
    assert_raise(ArgumentError) { @img.adaptive_resize }
  end

  def test_adaptive_sharpen
    assert_nothing_raised do
      res = @img.adaptive_sharpen
      assert_instance_of(Magick::Image, res)
    end
    assert_nothing_raised { @img.adaptive_sharpen(2) }
    assert_nothing_raised { @img.adaptive_sharpen(3, 2) }
    assert_raise(ArgumentError) { @img.adaptive_sharpen(3, 2, 2) }
  end

  def test_adaptive_sharpen_channel
    assert_nothing_raised do
      res = @img.adaptive_sharpen_channel
      assert_instance_of(Magick::Image, res)
    end
    assert_nothing_raised { @img.adaptive_sharpen_channel(2) }
    assert_nothing_raised { @img.adaptive_sharpen_channel(3, 2) }
    assert_nothing_raised { @img.adaptive_sharpen_channel(3, 2, Magick::RedChannel) }
    assert_nothing_raised { @img.adaptive_sharpen_channel(3, 2, Magick::RedChannel, Magick::BlueChannel) }
    assert_raise(ArgumentError) { @img.adaptive_sharpen(3, 2, 2) }
  end

  def test_adaptive_threshold
    assert_nothing_raised do
      res = @img.adaptive_threshold
      assert_instance_of(Magick::Image, res)
    end
    assert_nothing_raised { @img.adaptive_threshold(2) }
    assert_nothing_raised { @img.adaptive_threshold(2,4) }
    assert_nothing_raised { @img.adaptive_threshold(2,4,1) }
    assert_raise(ArgumentError) { @img.adaptive_threshold(2,4,1,2) }
  end

  def test_add_compose_mask
    mask = Magick::Image.new(20,20)
    assert_nothing_raised { @img.add_compose_mask(mask) }
    assert_nothing_raised { @img.delete_compose_mask }
    assert_nothing_raised { @img.add_compose_mask(mask) }
    assert_nothing_raised { @img.add_compose_mask(mask) }
    assert_nothing_raised { @img.delete_compose_mask }
    assert_nothing_raised { @img.delete_compose_mask }
  end

  def test_add_noise
    assert_nothing_raised { @img.add_noise(Magick::UniformNoise) }
    assert_nothing_raised { @img.add_noise(Magick::GaussianNoise) }
    assert_nothing_raised { @img.add_noise(Magick::MultiplicativeGaussianNoise) }
    assert_nothing_raised { @img.add_noise(Magick::ImpulseNoise) }
    assert_nothing_raised { @img.add_noise(Magick::LaplacianNoise) }
    assert_nothing_raised { @img.add_noise(Magick::PoissonNoise) }
    assert_raise(TypeError) { @img.add_noise(0) }
  end

  def test_add_noise_channel
    assert_nothing_raised { @img.add_noise_channel(Magick::UniformNoise) }
    assert_nothing_raised { @img.add_noise_channel(Magick::UniformNoise, Magick::RedChannel) }
    assert_nothing_raised { @img.add_noise_channel(Magick::GaussianNoise, Magick::BlueChannel) }
    assert_nothing_raised { @img.add_noise_channel(Magick::ImpulseNoise, Magick::GreenChannel) }
    assert_nothing_raised { @img.add_noise_channel(Magick::LaplacianNoise, Magick::RedChannel, Magick::GreenChannel) }
    assert_nothing_raised { @img.add_noise_channel(Magick::PoissonNoise, Magick::RedChannel, Magick::GreenChannel, Magick::BlueChannel) }

    # Not a NoiseType
    assert_raise(TypeError) { @img.add_noise_channel(1) }
    # Not a ChannelType
    assert_raise(TypeError) { @img.add_noise_channel(Magick::UniformNoise, Magick::RedChannel, 1) }
    # Too few arguments
    assert_raise(ArgumentError) { @img.add_noise_channel }
  end

  def add_delete_profile
    img = Magick::Image.read('cmyk.jpg'),first
    assert_nothing_raised { img.add_profile('cmyk.icm') }
    assert_nothing_raised { img.add_profile('srgb.icm') }
    img.each_profile { |name, value| assert_equal('icc', name) }
    assert_nothing_raised { img.delete_profile('icc') }
  end

  def test_affine_matrix
    affine = Magick::AffineMatrix.new(1, Math::PI/6, Math::PI/6, 1, 0, 0)
    assert_nothing_raised { @img.affine_transform(affine) }
    assert_raise(TypeError) { @img.affine_transform(0) }
    res = @img.affine_transform(affine)
    assert_instance_of(Magick::Image,  res)
  end

  # test alpha backward compatibility. Image#alpha w/o arguments acts like alpha?
  def test_alpha_compat
    assert_nothing_raised { @img.alpha }
    assert !@img.alpha
    assert_nothing_raised { @img.alpha Magick::ActivateAlphaChannel }
    assert @img.alpha
  end

  def test_alpha
    assert_nothing_raised { @img.alpha? }
    assert !@img.alpha?
    assert_nothing_raised { @img.alpha Magick::ActivateAlphaChannel }
    assert @img.alpha?
    assert_nothing_raised { @img.alpha Magick::DeactivateAlphaChannel }
    assert !@img.alpha?
    assert_nothing_raised { @img.alpha Magick::ResetAlphaChannel }
    assert_nothing_raised { @img.alpha Magick::SetAlphaChannel }
    @img.freeze
    assert_raise(FreezeError) { @img.alpha Magick::SetAlphaChannel }
  end

  def test_auto_gamma
     res = nil
     assert_nothing_raised { res = @img.auto_gamma_channel }
     assert_instance_of(Magick::Image, res)
     assert_not_same(@img, res)
     assert_nothing_raised { res = @img.auto_gamma_channel Magick::RedChannel }
     assert_nothing_raised { res = @img.auto_gamma_channel Magick::RedChannel, Magick::BlueChannel }
     assert_raise(TypeError) { @img.auto_gamma_channel(1) }
  end

  def test_auto_level
     res = nil
     assert_nothing_raised { res = @img.auto_level_channel }
     assert_instance_of(Magick::Image, res)
     assert_not_same(@img, res)
     assert_nothing_raised { res = @img.auto_level_channel Magick::RedChannel }
     assert_nothing_raised { res = @img.auto_level_channel Magick::RedChannel, Magick::BlueChannel }
     assert_raise(TypeError) { @img.auto_level_channel(1) }
  end

  def test_auto_orient
    assert_nothing_raised do
      res = @img.auto_orient
      assert_instance_of(Magick::Image, res)
      assert_not_same(@img, res)
    end

    assert_nothing_raised do
      res = @img.auto_orient!
      # When not changed, returns nil
      assert_nil(res)
    end
  end

  def test_bilevel_channel
    assert_raise(ArgumentError) { @img.bilevel_channel }
    assert_nothing_raised { @img.bilevel_channel(100) }
    assert_nothing_raised { @img.bilevel_channel(100, Magick::RedChannel) }
    assert_nothing_raised { @img.bilevel_channel(100, Magick::RedChannel, Magick::BlueChannel, Magick::GreenChannel, Magick::OpacityChannel) }
    assert_nothing_raised { @img.bilevel_channel(100, Magick::CyanChannel, Magick::MagentaChannel, Magick::YellowChannel, Magick::BlackChannel) }
    assert_nothing_raised { @img.bilevel_channel(100, Magick::GrayChannel) }
    assert_nothing_raised { @img.bilevel_channel(100, Magick::AllChannels) }
    assert_raise(TypeError) { @img.bilevel_channel(100, 2) }
    res = @img.bilevel_channel(100)
    assert_instance_of(Magick::Image,  res)
  end

  def test_blend
    @img2 = Magick::Image.new(20,20) {self.background_color = 'black'}
    assert_nothing_raised { @img.blend(@img2, 0.25) }
    res = @img.blend(@img2, 0.25)
    assert_instance_of(Magick::Image, res)
    assert_nothing_raised { @img.blend(@img2, '25%') }
    assert_nothing_raised { @img.blend(@img2, 0.25, 0.75) }
    assert_nothing_raised { @img.blend(@img2, '25%', '75%') }
    assert_nothing_raised { @img.blend(@img2, 0.25, 0.75, Magick::CenterGravity) }
    assert_nothing_raised { @img.blend(@img2, 0.25, 0.75, Magick::CenterGravity, 10) }
    assert_nothing_raised { @img.blend(@img2, 0.25, 0.75, Magick::CenterGravity, 10, 10) }
    assert_raise(ArgumentError) { @img.blend }
    assert_raise(ArgumentError) { @img.blend(@img2, 'x') }
    assert_raise(TypeError) { @img.blend(@img2, 0.25, []) }
    assert_raise(TypeError) { @img.blend(@img2, 0.25, 0.75, 'x') }
    assert_raise(TypeError) { @img.blend(@img2, 0.25, 0.75, Magick::CenterGravity, 'x') }
    assert_raise(TypeError) { @img.blend(@img2, 0.25, 0.75, Magick::CenterGravity, 10, []) }

    @img2.destroy!
    assert_raise(Magick::DestroyedImageError) { @img.blend(@img2, '25%') }
  end

  def test_blur_channel
    assert_nothing_raised { @img.blur_channel }
    assert_nothing_raised { @img.blur_channel(1) }
    assert_nothing_raised { @img.blur_channel(1,2) }
    assert_nothing_raised { @img.blur_channel(1,2, Magick::RedChannel) }
    assert_nothing_raised { @img.blur_channel(1,2, Magick::RedChannel, Magick::BlueChannel, Magick::GreenChannel, Magick::OpacityChannel) }
    assert_nothing_raised { @img.blur_channel(1,2, Magick::CyanChannel, Magick::MagentaChannel, Magick::YellowChannel, Magick::BlackChannel) }
    assert_nothing_raised { @img.blur_channel(1,2, Magick::GrayChannel) }
    assert_nothing_raised { @img.blur_channel(1,2, Magick::AllChannels) }
    assert_raise(TypeError) { @img.blur_channel(1,2,2) }
    res = @img.blur_channel
    assert_instance_of(Magick::Image,  res)
  end

  def test_blur_image
    assert_nothing_raised { @img.blur_image }
    assert_nothing_raised { @img.blur_image(1) }
    assert_nothing_raised { @img.blur_image(1,2) }
    assert_raise(ArgumentError) { @img.blur_image(1,2,3) }
    res = @img.blur_image
    assert_instance_of(Magick::Image,  res)
  end

  def test_black_threshold
    assert_raise(ArgumentError) { @img.black_threshold }
    assert_nothing_raised { @img.black_threshold(50) }
    assert_nothing_raised { @img.black_threshold(50, 50) }
    assert_nothing_raised { @img.black_threshold(50, 50, 50) }
    assert_nothing_raised { @img.black_threshold(50, 50, 50, 50) }
    assert_raise(ArgumentError) { @img.black_threshold(50, 50, 50, 50, 50) }
    res = @img.black_threshold(50)
    assert_instance_of(Magick::Image,  res)
  end

  def test_border
    assert_nothing_raised { @img.border(2, 2, 'red') }
    assert_nothing_raised { @img.border!(2, 2, 'red') }
    res = @img.border(2,2, 'red')
    assert_instance_of(Magick::Image,  res)
    @img.freeze
    assert_raise(FreezeError) { @img.border!(2,2, 'red') }
  end

  def test_change_geometry
    assert_raise(ArgumentError) { @img.change_geometry('sss') }
    assert_raise(LocalJumpError) { @img.change_geometry('100x100') }
    assert_nothing_raised do
      res = @img.change_geometry('100x100') { 1 }
      assert_equal(1, res)
    end
    assert_raise(ArgumentError) { @img.change_geometry([]) }
  end

  def test_changed?
#        assert_block { !@img.changed? }
#        @img.pixel_color(0,0,'red')
#        assert_block { @img.changed? }
  end

  def test_channel
    assert_nothing_raised { @img.channel(Magick::RedChannel) }
    assert_nothing_raised { @img.channel(Magick::BlueChannel) }
    assert_nothing_raised { @img.channel(Magick::GreenChannel) }
    assert_nothing_raised { @img.channel(Magick::OpacityChannel) }
    assert_nothing_raised { @img.channel(Magick::MagentaChannel) }
    assert_nothing_raised { @img.channel(Magick::CyanChannel) }
    assert_nothing_raised { @img.channel(Magick::YellowChannel) }
    assert_nothing_raised { @img.channel(Magick::BlackChannel) }
    assert_nothing_raised { @img.channel(Magick::GrayChannel) }
    assert_nothing_raised { @img.channel(Magick::AlphaChannel) }
    assert_nothing_raised { @img.channel(Magick::DefaultChannels) }
    assert_nothing_raised { @img.channel(Magick::HueChannel) }
    assert_nothing_raised { @img.channel(Magick::LuminosityChannel) }
    assert_nothing_raised { @img.channel(Magick::SaturationChannel) }
    assert_instance_of(Magick::Image, @img.channel(Magick::RedChannel))
    assert_raise(TypeError) { @img.channel(2) }
  end

  def test_channel_depth
    assert_nothing_raised { @img.channel_depth }
    assert_nothing_raised { @img.channel_depth(Magick::RedChannel) }
    assert_nothing_raised { @img.channel_depth(Magick::RedChannel, Magick::BlueChannel) }
    assert_nothing_raised { @img.channel_depth(Magick::GreenChannel, Magick::OpacityChannel) }
    assert_nothing_raised { @img.channel_depth(Magick::MagentaChannel, Magick::CyanChannel) }
    assert_nothing_raised { @img.channel_depth(Magick::CyanChannel, Magick::BlackChannel) }
    assert_nothing_raised { @img.channel_depth(Magick::GrayChannel) }
    assert_raise(TypeError) { @img.channel_depth(2) }
    assert_instance_of(Fixnum, @img.channel_depth(Magick::RedChannel))
  end

  def test_channel_extrema
    assert_nothing_raised do
      res = @img.channel_extrema
      assert_instance_of(Array, res)
      assert_equal(2, res.length)
      assert_kind_of(Integer, res[0])
      assert_kind_of(Integer, res[1])
    end
    assert_nothing_raised { @img.channel_extrema(Magick::RedChannel) }
    assert_nothing_raised { @img.channel_extrema(Magick::RedChannel, Magick::BlueChannel) }
    assert_nothing_raised { @img.channel_extrema(Magick::GreenChannel, Magick::OpacityChannel) }
    assert_nothing_raised { @img.channel_extrema(Magick::MagentaChannel, Magick::CyanChannel) }
    assert_nothing_raised { @img.channel_extrema(Magick::CyanChannel, Magick::BlackChannel) }
    assert_nothing_raised { @img.channel_extrema(Magick::GrayChannel) }
    assert_raise(TypeError) { @img.channel_extrema(2) }
  end

  def test_channel_mean
    assert_nothing_raised do
      res = @img.channel_mean
      assert_instance_of(Array, res)
      assert_equal(2, res.length)
      assert_instance_of(Float, res[0])
      assert_instance_of(Float, res[1])
    end
    assert_nothing_raised { @img.channel_mean(Magick::RedChannel) }
    assert_nothing_raised { @img.channel_mean(Magick::RedChannel, Magick::BlueChannel) }
    assert_nothing_raised { @img.channel_mean(Magick::GreenChannel, Magick::OpacityChannel) }
    assert_nothing_raised { @img.channel_mean(Magick::MagentaChannel, Magick::CyanChannel) }
    assert_nothing_raised { @img.channel_mean(Magick::CyanChannel, Magick::BlackChannel) }
    assert_nothing_raised { @img.channel_mean(Magick::GrayChannel) }
    assert_raise(TypeError) { @img.channel_mean(2) }
  end

  def test_charcoal
    assert_nothing_raised do
      res = @img.charcoal
      assert_instance_of(Magick::Image, res)
    end
    assert_nothing_raised { @img.charcoal(1.0) }
    assert_nothing_raised { @img.charcoal(1.0, 2.0) }
    assert_raise(ArgumentError) { @img.charcoal(1.0, 2.0, 3.0) }
  end

  def test_chop
    assert_nothing_raised do
      res = @img.chop(10, 10, 10, 10)
      assert_instance_of(Magick::Image, res)
    end
  end

  def test_clone
    assert_nothing_raised do
      res = @img.clone
      assert_instance_of(Magick::Image, res)
      assert_equal(res, @img)
    end
    res = @img.clone
    assert_equal(res.frozen?, @img.frozen?)
    @img.freeze
    res = @img.clone
    assert_equal(res.frozen?, @img.frozen?)
  end

  def test_clut_channel
    img = Magick::Image.new(20,20) {self.colorspace = Magick::GRAYColorspace}
    clut = Magick::Image.new(20,1) {self.background_color = 'red'}
    res = nil
    assert_nothing_raised {res = img.clut_channel(clut)}
    assert_same(res, img)
    assert_nothing_raised { img.clut_channel(clut, Magick::RedChannel) }
    assert_nothing_raised { img.clut_channel(clut, Magick::RedChannel, Magick::BlueChannel) }
    assert_raises(ArgumentError) { img.clut_channel(clut, 1, Magick::RedChannel) }
  end

  def test_color_fill_to_border
    assert_raise(ArgumentError) { @img.color_fill_to_border(-1, 1, 'red') }
    assert_raise(ArgumentError) { @img.color_fill_to_border(1, 100, 'red') }
    assert_nothing_raised do
      res = @img.color_fill_to_border(@img.columns/2, @img.rows/2, 'red')
      assert_instance_of(Magick::Image, res)
    end
    pixel = Magick::Pixel.new(Magick::QuantumRange)
    assert_nothing_raised { @img.color_fill_to_border(@img.columns/2, @img.rows/2, pixel) }
  end

  def test_color_floodfill
    assert_raise(ArgumentError) { @img.color_floodfill(-1, 1, 'red') }
    assert_raise(ArgumentError) { @img.color_floodfill(1, 100, 'red') }
    assert_nothing_raised do
      res = @img.color_floodfill(@img.columns/2, @img.rows/2, 'red')
      assert_instance_of(Magick::Image, res)
    end
    pixel = Magick::Pixel.new(Magick::QuantumRange)
    assert_nothing_raised { @img.color_floodfill(@img.columns/2, @img.rows/2, pixel) }
  end

  def test_color_histogram
    assert_nothing_raised do
      res = @img.color_histogram
      assert_instance_of(Hash, res)
    end
  end

  def test_colorize
    assert_nothing_raised do
      res = @img.colorize(0.25, 0.25, 0.25, 'red')
      assert_instance_of(Magick::Image, res)
    end
    assert_nothing_raised { @img.colorize(0.25, 0.25, 0.25, 0.25, 'red') }
    pixel = Magick::Pixel.new(Magick::QuantumRange)
    assert_nothing_raised { @img.colorize(0.25, 0.25, 0.25, pixel) }
    assert_nothing_raised { @img.colorize(0.25, 0.25, 0.25, 0.25, pixel) }
    assert_raise(ArgumentError) { @img.colorize }
    assert_raise(ArgumentError) { @img.colorize(0.25) }
    assert_raise(ArgumentError) { @img.colorize(0.25, 0.25) }
    assert_raise(ArgumentError) { @img.colorize(0.25, 0.25, 0.25) }
    assert_raise(ArgumentError) { @img.colorize(0.25, 0.25, 0.25, 'X') }
    # last argument must be a color name or pixel
    assert_raise(TypeError) { @img.colorize(0.25, 0.25, 0.25, 0.25) }
    assert_raise(ArgumentError) { @img.colorize(0.25, 0.25, 0.25, 0.25, 'X') }
    assert_raise(TypeError) { @img.colorize(0.25, 0.25, 0.25, 0.25, [2]) }
  end

  def test_colormap
    # IndexError b/c @img is DirectClass
    assert_raise(IndexError) { @img.colormap(0) }
    # Read PseudoClass image
    pc_img = Magick::Image.read(IMAGES_DIR+'/Button_0.gif').first
    assert_nothing_raised { pc_img.colormap(0) }
    ncolors = pc_img.colors
    assert_raise(IndexError) { pc_img.colormap(ncolors+1) }
    assert_raise(IndexError) { pc_img.colormap(-1) }
    assert_nothing_raised { pc_img.colormap(ncolors-1) }
    res = pc_img.colormap(0)
    assert_instance_of(String, res)

    #test 'set' operation
    assert_nothing_raised do
      old_color = pc_img.colormap(0)
      res = pc_img.colormap(0, 'red')
      assert_equal(old_color, res)
      res = pc_img.colormap(0)
      assert_equal('red', res)
    end
    pixel = Magick::Pixel.new(Magick::QuantumRange)
    assert_nothing_raised { pc_img.colormap(0, pixel) }
    assert_raise(TypeError) { pc_img.colormap(0, [2]) }
    pc_img.freeze
    assert_raise(FreezeError) { pc_img.colormap(0, 'red') }
  end

  def test_color_point
    assert_nothing_raised do
      res = @img.color_point(0, 0, 'red')
      assert_instance_of(Magick::Image, res)
      assert_not_same(@img, res)
    end
    pixel = Magick::Pixel.new(Magick::QuantumRange)
    assert_nothing_raised { @img.color_point(0, 0, pixel) }
  end

  def test_color_reset!
    assert_nothing_raised do
      res = @img.color_reset!('red')
      assert_same(@img, res)
    end
    pixel = Magick::Pixel.new(Magick::QuantumRange)
    assert_nothing_raised { @img.color_reset!(pixel) }
    assert_raise(TypeError) { @img.color_reset!([2]) }
    assert_raise(ArgumentError)  { @img.color_reset!('x') }
    @img.freeze
    assert_raise(FreezeError) { @img.color_reset!('red') }
  end

  def test_combine
    r = Magick::Image.new(20,20) { self.background_color = 'red' }
    g = Magick::Image.new(20,20) { self.background_color = 'green' }
    b = Magick::Image.new(20,20) { self.background_color = 'blue' }
    a = Magick::Image.new(20,20) { self.background_color = 'transparent' }
    assert_nothing_raised { Magick::Image.combine(r) }
    assert_nothing_raised { Magick::Image.combine(r, g) }
    assert_nothing_raised { Magick::Image.combine(r, g, b) }
    assert_nothing_raised { Magick::Image.combine(r, g, b, a) }
    assert_nothing_raised { Magick::Image.combine(nil, g) }
    assert_nothing_raised { Magick::Image.combine(r, nil, b) }
    assert_nothing_raised { Magick::Image.combine(r, g, nil, a) }
    assert_nothing_raised { Magick::Image.combine(r, g, b, nil) }
    res = Magick::Image.combine(r, g, b)
    assert_instance_of(Magick::Image, res)
    assert_raise(ArgumentError) { Magick::Image.combine }
    assert_raise(ArgumentError) { Magick::Image.combine(nil) }
    assert_raise(ArgumentError) { Magick::Image.combine(r, g, b, a, r) }
    assert_raise(TypeError) { Magick::Image.combine(1, g, b, a) }
  end

  def test_compare_channel
    img1 = Magick::Image.read(IMAGES_DIR+'/Button_0.gif').first
    img2 = Magick::Image.read(IMAGES_DIR+'/Button_1.gif').first
    assert_nothing_raised { img1.compare_channel(img2, Magick::MeanAbsoluteErrorMetric) }
    assert_nothing_raised { img1.compare_channel(img2, Magick::MeanSquaredErrorMetric) }
    assert_nothing_raised { img1.compare_channel(img2, Magick::PeakAbsoluteErrorMetric) }
    assert_nothing_raised { img1.compare_channel(img2, Magick::PeakSignalToNoiseRatioMetric) }
    assert_nothing_raised { img1.compare_channel(img2, Magick::RootMeanSquaredErrorMetric) }
    assert_raise(TypeError) { img1.compare_channel(img2, 2) }
    assert_raise(ArgumentError) { img1.compare_channel }

    ilist = Magick::ImageList.new
    ilist << img2
    assert_nothing_raised { img1.compare_channel(ilist, Magick::MeanAbsoluteErrorMetric) }

    assert_nothing_raised { img1.compare_channel(img2, Magick::MeanAbsoluteErrorMetric, Magick::RedChannel) }
    assert_nothing_raised { img1.compare_channel(img2, Magick::MeanAbsoluteErrorMetric, Magick::RedChannel, Magick::BlueChannel) }
    assert_raise(TypeError) { img1.compare_channel(img2, Magick::MeanAbsoluteErrorMetric, 2) }
    assert_raise(TypeError) { img1.compare_channel(img2, Magick::MeanAbsoluteErrorMetric, Magick::RedChannel, 2) }

    res = img1.compare_channel(img2, Magick::MeanAbsoluteErrorMetric)
    assert_instance_of(Array, res)
    assert_instance_of(Magick::Image, res[0])
    assert_instance_of(Float, res[1])

    img2.destroy!
    assert_raise(Magick::DestroyedImageError) { img1.compare_channel(img2, Magick::MeanAbsoluteErrorMetric) }
  end
end

if __FILE__ == $PROGRAM_NAME
IMAGES_DIR = '../doc/ex/images'
FILES = Dir[IMAGES_DIR+'/Button_*.gif']
Test::Unit::UI::Console::TestRunner.run(Image1_UT)  unless RUBY_VERSION[/^1\.9|^2/]
end
