# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_17_080500) do
  create_table "acceptable_use_policies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.date "effective_date"
    t.text "prohibited_content"
    t.text "prohibited_activities"
    t.text "user_responsibilities"
    t.text "enforcement_actions"
    t.text "reporting_violations"
    t.boolean "content_moderation"
    t.boolean "age_restrictions"
    t.boolean "commercial_use_allowed"
    t.index ["user_id"], name: "index_acceptable_use_policies_on_user_id", unique: true
  end

  create_table "cookie_policies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.date "effective_date"
    t.boolean "essential_cookies"
    t.boolean "analytics_cookies"
    t.boolean "marketing_cookies"
    t.boolean "preference_cookies"
    t.boolean "third_party_cookies"
    t.boolean "cookie_consent_required"
    t.string "cookie_banner_type"
    t.text "retention_periods"
    t.text "opt_out_methods"
    t.index ["user_id"], name: "index_cookie_policies_on_user_id", unique: true
  end

  create_table "disclaimers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.date "effective_date"
    t.string "disclaimer_type"
    t.boolean "liability_limitation"
    t.boolean "warranty_disclaimer"
    t.boolean "accuracy_disclaimer"
    t.boolean "external_links_disclaimer"
    t.boolean "professional_advice_disclaimer"
    t.index ["user_id"], name: "index_disclaimers_on_user_id", unique: true
  end

  create_table "organizations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "legal_name"
    t.string "industry"
    t.string "business_type"
    t.text "address"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "postal_code"
    t.string "phone"
    t.string "email"
    t.string "website"
    t.string "registration_number"
    t.string "tax_id"
    t.string "dpo_name"
    t.string "dpo_email"
    t.text "gdpr_representative"
    t.integer "data_retention_period"
    t.index ["user_id"], name: "index_organizations_on_user_id", unique: true
  end

  create_table "privacy_policies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.date "effective_date"
    t.text "data_types_collected"
    t.boolean "cookies_used"
    t.boolean "third_party_sharing"
    t.boolean "international_transfers"
    t.boolean "user_rights_access"
    t.boolean "user_rights_deletion"
    t.boolean "user_rights_portability"
    t.integer "data_retention_period"
    t.string "contact_method"
    t.boolean "gdpr_compliant"
    t.boolean "ccpa_compliant"
    t.index ["user_id"], name: "index_privacy_policies_on_user_id", unique: true
  end

  create_table "terms_of_services", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.date "effective_date"
    t.boolean "acceptance_required"
    t.integer "minimum_age"
    t.string "governing_law"
    t.string "jurisdiction"
    t.string "dispute_resolution"
    t.boolean "user_data_collection"
    t.integer "account_termination_notice_days"
    t.string "refund_policy"
    t.string "service_availability"
    t.string "user_generated_content_policy"
    t.index ["user_id"], name: "index_terms_of_services_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "acceptable_use_policies", "users"
  add_foreign_key "cookie_policies", "users"
  add_foreign_key "disclaimers", "users"
  add_foreign_key "organizations", "users"
  add_foreign_key "privacy_policies", "users"
  add_foreign_key "terms_of_services", "users"
end
