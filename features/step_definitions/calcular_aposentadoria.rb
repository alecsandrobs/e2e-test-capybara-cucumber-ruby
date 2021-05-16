
Dado('o usuário acessou o ambiente para calcular a aposentadoria') do
    visit('/#!/calculadora/aposentadoria')
    # expect(page).to have_current_path('https://alecsandro-imersao-javascript.herokuapp.com/#!/calculadora/aposentadoria')
end
  
Quando('digitar {string} no campo valor desejado') do |valor|
    find_by_id('desejado').send_keys(valor)
end
  
Quando('digitar {string} no campo anos de contribuição') do |anos|
    find_by_id('anos').send_keys(anos)
end
  
Quando('digitar {string} no campo taxa') do |taxa|
    find_by_id('taxa').send_keys(taxa)
end
  
Quando('clicar no botão com o texto {string}') do |texto|
    # find_button(texto).click
    click_button(texto)
    # click_on(texto)
end

Quando('clicar no {int}º botão com o texto {string}') do |ordem, texto|
    find_button(texto)[ordem-1].click
    # click_button(texto)
    # click_on(texto)
end
  
Então('deveria exibir {string} no valor a ser investido ao mês') do |resultado|
    expect(find('h3').text).to eq resultado
end
  