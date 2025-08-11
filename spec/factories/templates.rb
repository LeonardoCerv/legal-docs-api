FactoryBot.define do
  factory :template do
    title { "MyString" }
    slug { "MyString" }
    body { "MyText" }
    doc_type { 1 }
    version { 1 }
    published { false }
  end
end
