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

ActiveRecord::Schema[8.0].define(version: 2025_08_16_234634) do
  create_table "acceptable_use_policies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", default: "Acceptable Use Policy"
    t.text "generated_content"
    t.string "status"
    t.boolean "has_user_content", default: false
    t.text "content_restrictions"
    t.boolean "has_reporting", default: false
    t.text "enforcement_actions"
    t.boolean "has_appeals_process", default: false
    t.string "monitoring_policy"
    t.boolean "automated_moderation", default: false
    t.boolean "user_responsibility", default: false
    t.boolean "bandwidth_limits", default: false
    t.boolean "commercial_use_allowed", default: false
    t.boolean "resale_prohibited", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_acceptable_use_policies_on_user_id"
  end

  create_table "cookie_policies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", default: "Cookie Policy"
    t.text "generated_content"
    t.string "status"
    t.boolean "essential_cookies", default: false
    t.boolean "analytics_cookies", default: false
    t.boolean "marketing_cookies", default: false
    t.boolean "preference_cookies", default: false
    t.boolean "social_media_cookies", default: false
    t.boolean "cookie_banner", default: false
    t.text "third_party_cookies"
    t.string "cookie_duration"
    t.string "opt_out_method"
    t.boolean "cookie_refresh", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cookie_policies_on_user_id"
  end

  create_table "disclaimers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", default: "Disclaimer"
    t.text "generated_content"
    t.string "status"
    t.string "service_type"
    t.boolean "provides_advice", default: false
    t.string "advice_type"
    t.boolean "has_affiliates", default: false
    t.boolean "liability_limitation", default: false
    t.boolean "warranty_disclaimer", default: false
    t.boolean "accuracy_disclaimer", default: false
    t.boolean "third_party_links", default: false
    t.boolean "investment_disclaimer", default: false
    t.boolean "health_disclaimer", default: false
    t.boolean "educational_only", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_disclaimers_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "company_name"
    t.string "legal_name"
    t.string "contact_email"
    t.string "website_url"
    t.text "address"
    t.string "jurisdiction"
    t.string "industry"
    t.date "founded_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_organizations_on_user_id", unique: true
  end

  create_table "privacy_policies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", default: "Privacy Policy"
    t.text "generated_content"
    t.string "status"
    t.boolean "collects_personal_info", default: false
    t.text "data_types"
    t.boolean "uses_cookies", default: false
    t.text "third_party_services"
    t.boolean "shares_data", default: false
    t.boolean "sells_data", default: false
    t.string "data_retention_period"
    t.boolean "gdpr_compliant", default: false
    t.boolean "ccpa_compliant", default: false
    t.boolean "coppa_compliant", default: false
    t.boolean "has_children_users", default: false
    t.string "contact_method"
    t.boolean "data_protection_officer", default: false
    t.boolean "automated_decision_making", default: false
    t.boolean "cross_border_transfers", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_privacy_policies_on_user_id"
  end

  create_table "terms_of_services", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", default: "Terms of Service"
    t.text "generated_content"
    t.boolean "has_user_accounts", default: false
    t.boolean "accepts_payments", default: false
    t.string "payment_processor"
    t.boolean "has_subscription", default: false
    t.string "cancellation_policy"
    t.boolean "has_user_content", default: false
    t.boolean "content_moderation", default: false
    t.integer "age_restriction"
    t.boolean "has_api", default: false
    t.string "dispute_resolution"
    t.string "liability_cap"
    t.string "termination_notice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_terms_of_services_on_user_id"
  end

  add_foreign_key "acceptable_use_policies", "users"
  add_foreign_key "cookie_policies", "users"
  add_foreign_key "disclaimers", "users"
  add_foreign_key "organizations", "users"
  add_foreign_key "privacy_policies", "users"
  add_foreign_key "terms_of_services", "users"
end
