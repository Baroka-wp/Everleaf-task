FactoryBot.define do
  factory :label do
    title { "Label 1" }
  end

  factory :label2, class: Label do
  	title { "Label 2" }
  end
end
