require 'test_helper'

class ResourceTest < Minitest::Test
  Article = Struct.new(:title)
  User = Struct.new(:name)

  def setup
    @klass = Class.new(Kuebiko::Url)
  end

  test "use as internal accessor" do
    title = "first_day"
    @klass.class_eval { material :article }
    inst = @klass.new(Article.new(title))

    assert_equal title, inst.instance_eval { article.title }
  end

  test "can specify more than one material" do
    title = "second_day"
    name = "tsuka"
    @klass.class_eval { material :article, :user }
    inst = @klass.new(Article.new(title), User.new(name))

    assert_equal title, inst.instance_eval { article.title }
    assert_equal name, inst.instance_eval { user.name }
  end

  test "internal accessor returns nil if you do not pass to initializer" do
    title = "third_day"
    @klass.class_eval { material :article, :user }
    inst = @klass.new(Article.new(title))

    assert_equal title, inst.instance_eval { article.title }
    assert_nil inst.instance_eval { user }

    inst2 = @klass.new
    assert_nil inst2.instance_eval { article }
    assert_nil inst2.instance_eval { user }
  end

  test "can specify options" do
    time_num = Time.now.to_i
    inst = @klass.new(tsu: time_num)
    assert_equal time_num, inst.instance_eval { options[:tsu] }

    @klass.class_eval { material :article, :user }
    some_code = rand(100000)
    inst2 = @klass.new(oi: some_code)
    assert_equal some_code, inst2.instance_eval { options[:oi] }
  end
end
