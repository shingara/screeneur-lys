module GetCol

  class << self
    def get_map (login, password)
      agent = WWW::Mechanize.new
      agent.user_agent = 'Screeneur Lys Shingara'

      page = agent.get("http://www.conquest-lys.net/")
      
      login_form = page.forms.with.name("Flogon").first
      login_form.Nom = login
      login_form.Password = password
      logged_results = agent.submit(login_form)

      first_map = agent.click logged_results.links.with.text('Jouer')
      plateau_first = first_map.search "//table[@id='plateau']"
      
      second_map = agent.click first_map.links.with.text('change perso')
      plateau_second = second_map.search "//table[@id='plateau']"


      [plateau_first, plateau_second]
    end
  end
end
