module Test
require 'test_helper'
require "database_cleaner"
DatabaseCleaner.strategy = :truncation

class SelectorCustomerTest < Capybara::Rails::TestCase
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

  test "selector customer ok" do
    for lang in [:en, :fr]  
    I18n.locale = lang
    visit %Q!#{I18n.locale.to_s}/selectors/new!
    click_button('adm_lang')
    click_link(%Q!lang_#{I18n.locale.to_s}!)
    click_button('adm_user') 
    click_link('login')
    fill_in "user_email", with: 'test@gmail.com'
    fill_in "user_password", with: '12345678'
    click_button "user_login"
#test selector new
    fill_autocomplete "fake_indicator", with: "NY.GDP.PCAP.CN", select: "NY.GDP.PCAP.CN"
    fill_autocomplete "fake_country1", with: "France", select: "France"
    fill_autocomplete "fake_country2", with: "Allemagne", select: "Allemagne"
    fill_in "selector_year_begin", with: '2000'
    fill_in "selector_year_end", with: '2002'
    click_button "selector_submit"
    assert_selector 'div#chart'; puts("SelectorCustomerTest::chart assert chart OK")
    assert_text "France"; puts("SelectorCustomerTest::countries_modal assert France OK")
    assert_text "Allemagne"; puts("SelectorCustomerTest::countries_modal assert Allemagne OK")
    assert_selector 'span#print_link'; puts("SelectorCustomerTest::print assert print OK")
#test selector create
    fill_autocomplete "fake_indicator", with: "NY.GDP.PCAP.CD", select: "NY.GDP.PCAP.CD"
    fill_autocomplete "fake_country1", with: "Allemagne", select: "Allemagne"
    fill_autocomplete "fake_country2", with: "France", select: "France"
    fill_in "selector_year_begin", with: '2003'
    fill_in "selector_year_end", with: '2005'
    click_button "selector_submit"
    assert_selector 'div#chart'; puts("SelectorCustomerTest::chart assert chart OK")
    assert_text "France"; puts("SelectorCustomerTest::countries_modal assert France OK")
    assert_text "Allemagne"; puts("SelectorCustomerTest::countries_modal assert Allemagne OK") 
    assert_selector 'span#print_link'; puts("SelectorCustomerTest::print assert print_link OK")
    find('#print_link',:visible => true).click
    within_window(windows.last) do
        uri = URI.parse(current_url)
        assert_equal "data:application/pdf", uri.to_s.first(20) 
        puts("SelectorCustomerTest::print assert print page OK")
    end
    within_window(windows.first) do
        click_button('adm_user')
        click_link('logout')
    end    
    end
  end

  test "selector customer wrong indicators" do
   for page_from in ["new", "create"]   
   for indic in ["country1", "country2", "indicator1", "indicator2"]     
    for lang in [:en, :fr]  
    I18n.locale = lang
    visit %Q!#{I18n.locale.to_s}/selectors/new!
    click_button('adm_lang')
    click_link(%Q!lang_#{I18n.locale.to_s}!)
    click_button('adm_user') 
    click_link('login')
    fill_in "user_email", with: 'test@gmail.com'
    fill_in "user_password", with: '12345678'
    click_button "user_login"
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
        fill_autocomplete "fake_country2", with: "Allemagne", select: "Allemagne"
    end    
    case indic
    when "country1"
        fill_autocomplete "fake_country1", with: "allemagne", select: "allemagne"
    when "country2"
        fill_autocomplete "fake_country2", with: "allemagne", select: "allemagne" 
    when "indicator1"
        fill_autocomplete "fake_indicator", with: "NY.GDP.PCAP.cd", select: "NY.GDP.PCAP.cd"  
    when "indicator2"
        fill_autocomplete "fake_indicator2", with: "ny.GDP.PCAP.CD", select: "ny.GDP.PCAP.CD"
    end    
    fill_in "selector_year_begin", with: '2000'
    fill_in "selector_year_end", with: '2002'
    click_button "selector_submit"
    assert_selector "div.alert", text: I18n.t('wrong_worldbank_fetch')
    puts(%Q!SelectorCustomerTest::wrong_#{indic} assert flash "#{I18n.t('wrong_worldbank_fetch')}"!)
    click_button('adm_user')
    click_link('logout')
    end
   end
   end
  end
 
end
end
