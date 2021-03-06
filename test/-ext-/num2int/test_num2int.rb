require 'test/unit'

class TestNum2int < Test::Unit::TestCase
  module Num2int
  end
  require '-test-/num2int/num2int'

  SHRT_MIN = -32768
  SHRT_MAX = 32767
  USHRT_MAX = 65535

  INT_MIN = -2147483648
  INT_MAX = 2147483647
  UINT_MAX = 4294967295

  case [0].pack('L!').size
  when 4
    LONG_MAX = 2147483647
    LONG_MIN = -2147483648
    ULONG_MAX = 4294967295
  when 8
    LONG_MAX = 9223372036854775807
    LONG_MIN = -9223372036854775808
    ULONG_MAX = 18446744073709551615
  end

  LLONG_MAX = 9223372036854775807
  LLONG_MIN = -9223372036854775808
  ULLONG_MAX = 18446744073709551615

  FIXNUM_MAX = LONG_MAX/2
  FIXNUM_MIN = LONG_MIN/2

  def assert_num2i_success(type, num, result=num)
    method = "print_num2#{type}"
    assert_output(result.to_s) do
      Num2int.send(method, num)
    end
    if num.to_f.to_i == num
      assert_output(result.to_s) do
	Num2int.send(method, num.to_f)
      end
    end
  end

  def assert_num2i_error(type, num)
    method = "print_num2#{type}"
    assert_raise(RangeError) do
      Num2int.send(method, num)
    end
    if num.to_f.to_i == num
      assert_raise(RangeError) do
	Num2int.send(method, num)
      end
    end
  end

  def test_num2short
    assert_num2i_success(:short, SHRT_MIN)
    assert_num2i_success(:short, SHRT_MAX)
    assert_num2i_error(:short, SHRT_MIN-1)
    assert_num2i_error(:short, SHRT_MAX+1)
  end

  def test_num2ushort
    assert_num2i_success(:ushort, 0)
    assert_num2i_success(:ushort, USHRT_MAX)
    assert_num2i_success(:ushort, -1, USHRT_MAX)
    assert_num2i_success(:ushort, SHRT_MIN, SHRT_MAX+1)
    assert_num2i_error(:ushort, SHRT_MIN-1)
    assert_num2i_error(:ushort, USHRT_MAX+1)
  end

  def test_num2int
    assert_num2i_success(:int, INT_MIN)
    assert_num2i_success(:int, INT_MAX)
    assert_num2i_error(:int, INT_MIN-1)
    assert_num2i_error(:int, INT_MAX+1)
  end

  def test_num2uint
    assert_num2i_success(:uint, 0)
    assert_num2i_success(:uint, UINT_MAX)
    assert_num2i_success(:uint, -1, UINT_MAX)
    assert_num2i_success(:uint, INT_MIN, INT_MAX+1)
    assert_num2i_error(:uint, INT_MIN-1)
    assert_num2i_error(:uint, UINT_MAX+1)
  end

  def test_num2long
    #assert_output(LONG_MIN.to_s) do
    #  Num2int.print_num2long(LONG_MIN.to_f)
    #end
    assert_num2i_success(:long, LONG_MIN)
    assert_num2i_success(:long, LONG_MAX)
    assert_num2i_error(:long, LONG_MIN-1)
    assert_num2i_error(:long, LONG_MAX+1)
    assert_num2i_success(:long, FIXNUM_MIN)
    assert_num2i_success(:long, FIXNUM_MIN-1)
    assert_num2i_success(:long, FIXNUM_MAX)
    assert_num2i_success(:long, FIXNUM_MAX+1)
  end

  def test_num2ulong
    assert_num2i_success(:ulong, 0)
    assert_num2i_success(:ulong, ULONG_MAX)
    assert_num2i_success(:ulong, -1, ULONG_MAX)
    assert_num2i_success(:ulong, LONG_MIN, LONG_MAX+1)
    assert_num2i_error(:ulong, LONG_MIN-1)
    assert_num2i_error(:ulong, ULONG_MAX+1)
    assert_num2i_success(:ulong, FIXNUM_MIN, ULONG_MAX-FIXNUM_MAX)
    assert_num2i_success(:ulong, FIXNUM_MIN-1, ULONG_MAX-FIXNUM_MAX-1)
    assert_num2i_success(:ulong, FIXNUM_MAX, FIXNUM_MAX)
    assert_num2i_success(:ulong, FIXNUM_MAX+1, FIXNUM_MAX+1)
  end

  def test_num2ll
    assert_num2i_success(:ll, LLONG_MIN)
    assert_num2i_success(:ll, LLONG_MAX)
    assert_num2i_error(:ll, LLONG_MIN-1)
    assert_num2i_error(:ll, LLONG_MAX+1)
    assert_num2i_success(:ll, FIXNUM_MIN)
    assert_num2i_success(:ll, FIXNUM_MIN-1)
    assert_num2i_success(:ll, FIXNUM_MAX)
    assert_num2i_success(:ll, FIXNUM_MAX+1)
  end if defined?(Num2int.print_num2ll)

  def test_num2ull
    assert_num2i_success(:ull, 0)
    assert_num2i_success(:ull, ULLONG_MAX)
    assert_num2i_success(:ull, -1, ULLONG_MAX)
    assert_num2i_success(:ull, LLONG_MIN, LLONG_MAX+1)
    assert_num2i_error(:ull, LLONG_MIN-1)
    assert_num2i_error(:ull, ULLONG_MAX+1)
    assert_num2i_success(:ull, FIXNUM_MIN, ULLONG_MAX-FIXNUM_MAX)
    assert_num2i_success(:ull, FIXNUM_MIN-1, ULLONG_MAX-FIXNUM_MAX-1)
    assert_num2i_success(:ull, FIXNUM_MAX)
    assert_num2i_success(:ull, FIXNUM_MAX+1)
  end if defined?(Num2int.print_num2ull)
end


