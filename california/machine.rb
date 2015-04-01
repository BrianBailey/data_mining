require 'rubygems'
require 'ai4r'
require 'csv'




data_set = []

  CSV::Reader.parse('id3.csv', 'r') do |row|
    data_set << row
  end
  data_labels = data_set.shift

 id3 = Ai4r::Classifiers::ID3.new(data_set, data_labels)




id3.get_rules
     if age_range=='<30' then marketing_target='Y'
          elsif age_range=='[30-50)' and city=='Chicago' then marketing_target='Y'
          elsif age_range=='[30-50)' and city=='New York' then marketing_target='N'
          elsif age_range=='[50-80]' then marketing_target='N'
          elsif age_range=='>80' then marketing_target='Y'
          else raise 'There was not enough information during training to do a proper induction for this data element' end

  id3.eval(['New York', '<30', 'M'])
    # =>  'Y'