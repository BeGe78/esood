require 'test_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE
#   Version 3, 29 June 2007
# Integration tests for statistics handling for an anonymous user by {SelectorsController **SelectorsController**}  
class SelectorAnonymousTest < Capybara::Rails::TestCase
  include FactoryBot::Syntax::Methods
  self.use_transactional_fixtures = false
  setup do
    DatabaseCleaner.start
    Capybara.current_driver = :selenium     
    @role = FactoryBot.create(:admin)
    @role1 = FactoryBot.create(:customer)
    @user = FactoryBot.create(:user, role_id: @role1.id)
    @country = FactoryBot.create(:france)
    @country = FactoryBot.create(:italie)
    @country = FactoryBot.create(:allemagne)
    @country = FactoryBot.create(:france1)
    @country = FactoryBot.create(:italie1)
    @country = FactoryBot.create(:germany)
    @indicator = FactoryBot.create(:indic1)
    @indicator = FactoryBot.create(:indic2)
    @indicator = FactoryBot.create(:indic3)
    @indicator = FactoryBot.create(:indic4)
  end
  teardown do
    DatabaseCleaner.clean
  end
  # special function to select fields in an autocomplete list  
  def fill_autocomplete(field, options = {})
    fill_in field, with: options[:with]
    page.execute_script %{ $('##{field}').trigger('focus') }
    page.execute_script %{ $('##{field}').trigger('keydown') }
    selector = %{ul.ui-autocomplete li.ui-menu-item a:contains("#{options[:select]}")}
    page.has_selector?('ul.ui-autocomplete li.ui-menu-item a')
    page.execute_script %{ $('#{selector}').trigger('mouseenter').click() }
  end
  # Successful tests due to access control with language :en and :fr
  test 'selector_anonymous_ok' do
    [:en, :fr].each do |lang|  
      I18n.locale = lang
      visit %(#{I18n.locale}/selectors/new)
      click_button('adm_lang')
      click_link(%(lang_#{I18n.locale}))
      # test selector new
      fill_autocomplete 'fake_indicator', with: 'NE.RSB.GNFS.ZS', select: 'NE.RSB.GNFS.ZS'
      fill_autocomplete 'fake_country1', with: 'France', select: 'France'
      fill_autocomplete 'fake_country2', with: 'Italie', select: 'Italie'
      fill_in 'selector_year_begin', with: '2000'
      fill_in 'selector_year_end', with: '2010'
      click_button 'selector_submit'
      assert_selector 'div#chart'
      puts('SelectorAnonymousTest::chart assert chart OK')
      assert_text 'France'
      puts('SelectorAnonymousTest::countries_modal assert France OK')
      assert_no_text 'Allemagne'
      puts('SelectorAnonymousTest::countries_modal assert Allemagne KO')
      assert_no_selector 'span#print_link'
      puts('SelectorAnonymousTest::print assert print_link KO')
      # test selector create
      fill_autocomplete 'fake_indicator', with: 'NE.RSB.GNFS.ZS', select: 'NE.RSB.GNFS.ZS'
      fill_autocomplete 'fake_country1', with: 'Italie', select: 'Italie'
      fill_autocomplete 'fake_country2', with: 'France', select: 'France'
      fill_in 'selector_year_begin', with: '2003'
      fill_in 'selector_year_end', with: '2005'
      click_button 'selector_submit'
      assert_selector 'div#chart'
      puts('SelectorAnonymousTest::chart assert chart OK')
      assert_text 'France'
      puts('SelectorAnonymousTest::countries_modal assert France OK')
      assert_no_text 'Allemagne'
      puts('SelectorAnonymousTest::countries_modal assert Allemagne KO')
      assert_no_selector 'span#print_link'
      puts('SelectorAnonymousTest::print assert print_link KO')    
    end
  end
  # Unsuccessful tests due to access control with language :en and :fr
  test 'selector_anonymous_wrong_indicators' do
    %w(new create).each do |page_from|   
      %w(country1 country2 indicator1 indicator2).each do |indic|    
        [:en, :fr].each do |lang|    
          I18n.locale = lang
          visit %(#{I18n.locale}/selectors/new)
          click_button('adm_lang')
          click_link(%(lang_#{I18n.locale}))
          if page_from != 'new' # go to selectors/create
            fill_autocomplete 'fake_indicator', with: 'NE.RSB.GNFS.ZS', select: 'NE.RSB.GNFS.ZS' 
            fill_autocomplete 'fake_country1', with: 'France', select: 'France'
            fill_autocomplete 'fake_country2', with: 'Italie', select: 'Italie'
            fill_in 'selector_year_begin', with: '2000'
            fill_in 'selector_year_end', with: '2012'
            click_button 'selector_submit'
          end        
          indic != 'indicator2' ? click_button('b_country') : click_button('b_indicator')
          # test selector new
          fill_autocomplete 'fake_indicator', with: 'NE.RSB.GNFS.ZS', select: 'NE.RSB.GNFS.ZS' 
          fill_autocomplete 'fake_country1', with: 'France', select: 'France'
          if indic != 'indicator2' 
            fill_autocomplete 'fake_country2', with: 'Italie', select: 'Italie'
          end    
          case indic
          when 'country1'
            fill_autocomplete 'fake_country1', with: 'Allemagne', select: 'Allemagne'
          when 'country2'
            fill_autocomplete 'fake_country2', with: 'Allemagne', select: 'Allemagne' 
          when 'indicator1'
            fill_autocomplete 'fake_indicator', with: 'NY.GDP.PCAP.CD', select: 'NY.GDP.PCAP.CD'  
          when 'indicator2'
            fill_autocomplete 'fake_indicator2', with: 'NY.GDP.PCAP.CD', select: 'NY.GDP.PCAP.CD'
          end    
          fill_in 'selector_year_begin', with: '2000'
          fill_in 'selector_year_end', with: '2012'
          click_button 'selector_submit'
          assert_selector 'div.alert', text: I18n.t('wrong_worldbank_fetch')
          puts(%(SelectorAnonymousTest::wrong_#{indic} assert flash '#{I18n.t('wrong_worldbank_fetch')}'))
        end
      end
    end
  end 
end
