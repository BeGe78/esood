require 'test_helper'
require "database_cleaner"
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Integration tests for statistics handling for a connected user by {SelectorsController **SelectorsController**} 
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
#special function to select fields in an autocomplete list  
  def fill_autocomplete(field, options = {})
    fill_in field, with: options[:with]
    page.execute_script %Q{ $('##{field}').trigger('focus') }
    page.execute_script %Q{ $('##{field}').trigger('keydown') }
    selector = %Q{ul.ui-autocomplete li.ui-menu-item a:contains("#{options[:select]}")}
    page.has_selector?('ul.ui-autocomplete li.ui-menu-item a')
    page.execute_script %Q{ $('#{selector}').trigger('mouseenter').click() }
  end
#Successful tests due to access control with language :en and :fr
  test "selector_customer_ok" do
   for indic in ["country", "indicator"]   
    for lang in [:en, :fr]  
    I18n.locale = lang
    visit %Q!#{I18n.locale.to_s}/selectors/new!
    click_button('adm_lang')
    click_link(%Q!lang_#{I18n.locale.to_s}!)
    click_button('adm_user') 
    sleep(1)
    click_link('login')
    sleep(1)
    fill_in "user_email", with: 'test@gmail.com'
    fill_in "user_password", with: '12345678'
    click_button "user_login"
#test selector new
    fill_autocomplete "fake_indicator", with: "NE.RSB.GNFS.ZS", select: "NE.RSB.GNFS.ZS"
    fill_autocomplete "fake_country1", with: "France", select: "France"
    fill_in "selector_year_begin", with: '2000'
    fill_in "selector_year_end", with: '2012'
    indic != "indicator" ? click_button('b_country') : click_button('b_indicator')
    case indic
    when "country"
        fill_autocomplete "fake_country2", with: "Allemagne", select: "Allemagne"
    when "indicator"
        fill_autocomplete "fake_indicator2", with: "NY.GDP.PCAP.CD", select: "NY.GDP.PCAP.CD"
    end
    click_button "selector_submit"    
    assert_selector 'div#chart'; puts("SelectorCustomerTest::chart assert chart OK")
    assert_text "France"; puts("SelectorCustomerTest::countries_modal assert France OK")
    assert_selector 'span#print_link'; puts("SelectorCustomerTest::print assert print OK")
#test selector create
    fill_autocomplete "fake_indicator", with: "NY.GDP.PCAP.CD", select: "NY.GDP.PCAP.CD"
    fill_autocomplete "fake_country1", with: "Allemagne", select: "Allemagne"
    fill_in "selector_year_begin", with: '2003'
    fill_in "selector_year_end", with: '2005'
    case indic
    when "country"
        fill_autocomplete "fake_country2", with: "France", select: "france"
    when "indicator"
        fill_autocomplete "fake_indicator2", with: "NE.RSB.GNFS.ZS", select: "NE.RSB.GNFS.ZS"
    end
    click_button "selector_submit"
    assert_selector 'div#chart'; puts("SelectorCustomerTest::chart assert chart OK")
    assert_text "Allemagne"; puts("SelectorCustomerTest::countries_modal assert France OK")
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
  end
#Unsuccessful tests due to wrong parameters with language :en and :fr
  test "selector_customer_wrong_indicators" do
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
      fill_autocomplete "fake_indicator", with: "NE.RSB.GNFS.ZS", select: "NE.RSB.GNFS.ZS" 
      fill_autocomplete "fake_country1", with: "France", select: "France"
      fill_autocomplete "fake_country2", with: "Italie", select: "Italie"
      fill_in "selector_year_begin", with: '2000'
      fill_in "selector_year_end", with: '2012'
      click_button "selector_submit"
    end        
    indic != "indicator2" ? click_button('b_country') : click_button('b_indicator')
#test selector new
    fill_autocomplete "fake_indicator", with: "NE.RSB.GNFS.ZS", select: "NE.RSB.GNFS.ZS" 
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
    fill_in "selector_year_end", with: '2012'
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
