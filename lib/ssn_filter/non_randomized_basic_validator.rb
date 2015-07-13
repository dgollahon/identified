# Checks the few simple cases that apply to ssns prior to June 25, 2011
class NonRandomizedBasicValidator < BasicValidator
  private

  # Prior to June 25, 2011 areas of 734-749 and above 772 were not used
  def area_valid?
    super && !(734..749).include?(@ssn.area) && @ssn.area <= 772
  end
end
