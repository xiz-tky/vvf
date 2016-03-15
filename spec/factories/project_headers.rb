include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :project_header_en, class: :project_header do
    project nil
    language Language.coded(:en)
    title "MyString"
    image "path/to/image"
  end

  factory :project_header_vi, class: :project_header do
    project nil
    language Language.coded(:vi)
    title "MyString"
    image "path/to/image"
  end

  factory :project_header_ja, class: :project_header do
    project nil
    language Language.coded(:ja)
    title "MyString"
    image "path/to/image"
  end
end
