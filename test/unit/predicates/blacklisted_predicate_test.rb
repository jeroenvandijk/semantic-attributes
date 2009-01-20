require File.expand_path(File.dirname(__FILE__) + '/../../test_helper')

class BlacklistedPredicateTest < Test::Unit::TestCase
  def setup
    @predicate = Predicates::Blacklisted.new(:foo)
  end

  def test_case_insensitive_validation
    @predicate.case_sensitive = false
    @predicate.restricted = [1, "foo"]
    assert !@predicate.validate(1, nil)
    assert !@predicate.validate("1", nil)
    assert !@predicate.validate("foo", nil)
    assert !@predicate.validate("foO", nil)
  end
  
  def test_case_sensitive_validation
    @predicate.case_sensitive = true
  
    @predicate.restricted = [1, 2, '3']

    assert !@predicate.validate(1, nil)
    assert !@predicate.validate(2, nil)
    assert @predicate.validate(3, nil), 'type is important'
    assert !@predicate.validate('3', nil)
    assert @predicate.validate(6, nil)
  end
  
  def test_error_message
    assert_equal "is not an allowed option.", @predicate.error_message
    @predicate.error_message = 'foo'
    assert_equal 'foo', @predicate.error_message
  end
end
