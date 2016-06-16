require "minitest_helper"

class TestFancyToProc < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FancyToProc::VERSION
  end

  # integration tests

  def test_it_all_works_together
    assert_equal ["bANANA", "hADDOCK"],
      ["banana  ", "hammock!"].map(&:strip&:capitalize&:sub.(/mm/, "dd")&(:delete|"!")&:swapcase)
  end
end

class TestSymbol < Minitest::Test
  # tilde method

  def test_it_has_tilde_method
    assert_respond_to :foo, :~
  end

  def test_tilde_returns_proc
    assert_kind_of Proc, ~:p
  end

  def test_tilde_works
    assert_output("foo\n") do
      (~:puts).call("foo")
    end
  end

  # ampersand method

  def test_it_has_ampersand_method
    assert_respond_to :foo, :&
  end

  def test_ampersand_returns_proc
    assert_kind_of Proc, :foo&:bar
  end

  def test_ampersand_works
    assert_equal "hello", (:strip&:downcase)[" Hello"]
  end

  # pipe method

  def test_it_has_pipe_method
    assert_respond_to :foo, :|
  end

  def test_pipe_returns_proc
    assert_kind_of Proc, :foo|42
  end

  def test_pipe_works
    assert_equal "Hello", (:delete|"!")["Hello!"]
  end

  # call method

  def test_it_has_call_method
    assert_respond_to :foo, :call
  end

  def test_call_returns_proc
    assert_kind_of Proc, :foo.()
  end

  def test_call_works
    assert_equal "haddock", :sub.(/mm/, "dd")["hammock"]
  end
end

class TestProc < Minitest::Test
  # ampersand method

  def test_it_has_ampersand_method
    assert_respond_to proc {}, :&
  end

  def test_ampersand_returns_proc
    assert_kind_of Proc, (proc {}) & :bar
  end

  def test_ampersand_works
    assert_equal "hello", (:strip.to_proc&:downcase)[" Hello"]
  end

  # pipe method

  def test_it_has_pipe_method
    assert_respond_to proc {}, :|
  end

  def test_pipe_returns_proc
    assert_kind_of Proc, (proc {}) | 42
  end

  def test_pipe_works
    assert_output "World!" do
      (method(:print).to_proc | "World")["!"]
    end
  end

  def test_pipe_is_chainable
    assert_output "Hello, World!" do
      (method(:print).to_proc | "Hello," | " World")["!"]
    end
  end
end

class TestArray < Minitest::Test
  def test_it_has_to_proc_method
    assert_respond_to [], :to_proc
  end

  def test_to_proc_returns_proc
    assert_kind_of Proc, [].to_proc
  end

  def test_to_proc_works_on_arrays
    assert_equal [:ab, :bb], [[:aa, :ab, :ac], [:ba, :bb, :bc]].map(&[1])
  end

  def test_to_proc_works_on_arrays_with_multiple_args
    assert_equal [[:aa, :ab], [:ba, :bb]],
      [[:aa, :ab, :ac], [:ba, :bb, :bc]].map(&[0, 2])
  end

  def test_to_proc_works_on_hashes
    assert_equal [11, 22], [{ a: 11 }, { a: 22 }].map(&[:a])
  end
end
