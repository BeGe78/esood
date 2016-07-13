module Test
require 'test_helper'
require "database_cleaner"
DatabaseCleaner.strategy = :truncation

class SelectorAnonymousTest < Capybara::Rails::TestCase
  include FactoryGirl::Syntax::Methods
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    Capybara.current_driver = :selenium     
    @role = FactoryGirl.create(:admin)
    @role1 = FactoryGirl.create(:customer)
    @user = FactoryGirl.create(:user, role_id: @role1.id)
    @country = FactoryGirl.create(:france)
    @country = FactoryGirl.create(:italie)
    @country = FactoryGirl.create(:allemagne)
    @country = FactoryGirl.create(:france1)
    @country = FactoryGirl.create(:italie1)
    @country = FactoryGirl.create(:germany)
    @indicator = FactoryGirl.create(:indic1)
    @indicator = FactoryGirl.create(:indic2)
    @indicator = FactoryGirl.create(:indic3)
    @indicator = FactoryGirl.create(:indic4)
  end
  teardown do
    DatabaseCleaner.clean
  end  
  def fill_autocomplete(field, options = {})
    fill_in field, with: options[:with]
    page.execute_script %Q{ $('##{field}').trigger('focus') }
    page.execute_script %Q{ $('##{field}').trigger('keydown') }
    selector = %Q{ul.ui-autocomplete li.ui-menu-item a:contains("#{options[:select]}")}
    page.has_selector?('ul.ui-autocomplete li.ui-menu-item a')
    page.execute_script %Q{ $('#{selector}').trigger('mouseenter').click() }
  end

  test "selector anonymous ok" do
    for lang in [:en, :fr]  
    I18n.locale = lang
    visit %Q!#{I18n.locale.to_s}/selectors/new!
    click_button('adm_lang')
    click_link(%Q!lang_#{I18n.locale.to_s}!)
#test selector new
    fill_autocomplete "fake_indicator", with: "NY.GDP.PCAP.CN", select: "NY.GDP.PCAP.CN"
    fill_autocomplete "fake_country1", with: "France", select: "France"
    fill_autocomplete "fake_country2", with: "Italie", select: "Italie"
    fill_in "selector_year_begin", with: '2000'
    fill_in "selector_year_end", with: '2002'
    click_button "selector_submit"
    assert_selector 'div#chart'; puts("SelectorAnonymousTest::chart assert chart OK")
    assert_text "France"; puts("SelectorAnonymousTest::countries_modal assert France OK")
    assert_no_text "Allemagne"; puts("SelectorAnonymousTest::countries_modal assert Allemagne KO")
#test selector create
    fill_autocomplete "fake_indicator", with: "NY.GDP.PCAP.CN", select: "NY.GDP.PCAP.CN"
    fill_autocomplete "fake_country1", with: "Italie", select: "Italie"
    fill_autocomplete "fake_country2", with: "France", select: "France"
    fill_in "selector_year_begin", with: '2003'
    fill_in "selector_year_end", with: '2005'
    click_button "selector_submit"
    assert_selector 'div#chart'; puts("SelectorAnonymousTest::chart assert chart OK")
    assert_text "France"; puts("SelectorAnonymousTest::countries_modal assert France OK")
    assert_no_text "Allemagne"; puts("SelectorAnonymousTest::countries_modal assert Allemagne KO")    
    end
  end

  test "selector anonymous wrong indicators" do
   for page_from in ["new", "create"]   
   for indic in ["country1", "country2", "indicator1", "indicator2"]     
    for lang in [:en, :fr]  
    I18n.locale = lang
    visit %Q!#{I18n.locale.to_s}/selectors/new!
    click_button('adm_lang')
    click_link(%Q!lang_#{I18n.locale.to_s}!)
    if page_from != "new"       #go to selectors/create
      fill_autocomplete "fake_indicator", with: "NY.GDP.PCAP.CN", select: "NY.GDP.PCAP.CN" 
      fill_autocomplete "fake_country1", with: "France", select: "France"
      fill_autocomplete "fake_country2", with: "Italie", select: "Italie"
      fill_in "selector_year_begin", with: '2000'
      fill_in "selector_year_end", with: '2002'
      click_button "selector_submit"
    end        
    indic != "indicator2" ? click_button('b_country') : click_button('b_indicator')
#test selector new
    fill_autocomplete "fake_indicator", with: "NY.GDP.PCAP.CN", select: "NY.GDP.PCAP.CN" 
    fill_autocomplete "fake_country1", with: "France", select: "France"
    if indic != "indicator2" 
        fill_autocomplete "fake_country2", with: "Italie", select: "Italie"
    end    
    case indic
    when "country1"
        fill_autocomplete "fake_country1", with: "Allemagne", select: "Allemagne"
    when "country2"
        fill_autocomplete "fake_country2", with: "Allemagne", select: "Allemagne" 
    when "indicator1"
        fill_autocomplete "fake_indicator", with: "NY.GDP.PCAP.CD", select: "NY.GDP.PCAP.CD"  
    when "indicator2"
        fill_autocomplete "fake_indicator2", with: "NY.GDP.PCAP.CD", select: "NY.GDP.PCAP.CD"
    end    
    fill_in "selector_year_begin", with: '2000'
    fill_in "selector_year_end", with: '2002'
    click_button "selector_submit"
    assert_selector "div.alert", text: I18n.t('wrong_worldbank_fetch')
    puts(%Q!SelectorAnonymousTest::wrong_#{indic} assert flash "#{I18n.t('wrong_worldbank_fetch')}"!)
    end
   end
   end
  end
 
end
end
