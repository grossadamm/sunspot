require File.join(File.dirname(__FILE__), 'test_helper')
require 'extlib'
lib_require 'sunspot', 'field_builder'

class FieldBuilderTest < Test::Unit::TestCase
  def test_build_attribute_field
    Sunspot::AttributeField.stubs(:new).with(:title, Sunspot::Type::StringType).returns attribute_field
    Sunspot::Fields.expects(:add).with Post, attribute_field
    builder.string :title
  end

  def test_build_nonexistent_type
    assert_raises(NoMethodError) do
      builder.nonsense :title
    end
  end

  def test_build_virtual_field
    Sunspot::VirtualField.stubs(:new).with(:categories, Sunspot::Type::StringType).returns virtual_field
    Sunspot::Fields.expects(:add).with Post, virtual_field
    builder.string(:categories) { all_categories }
  end

  public

  def builder
    Sunspot::FieldBuilder.new(Post)
  end

  def attribute_field
    @attribute_field ||= stub('AttributeField')
  end

  def virtual_field
    @virtual_field ||= stub('VirtualField')
  end
end

module Sunspot
  class AttributeField
  end

  class VirtualField
  end

  class Fields
  end

  class Type
    StringType = Module.new
  end
end
