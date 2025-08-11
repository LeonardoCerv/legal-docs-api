class Template < ApplicationRecord
  enum doc_type: { type1: 0, type2: 1, type3: 2 }
end
