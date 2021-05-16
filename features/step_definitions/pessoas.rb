Given('que não existem pessoas') do
    teste = RestClient.get("#{CONFIG['url']}/pessoas")
    # teste = RestClient.get("#{CONFIG['url']}/pessoas", headers={content_type: :json})

    pessoas = JSON.parse(teste.body)

    pessoas.each do |pessoa|
        RestClient.delete("#{CONFIG['url']}/pessoas/#{pessoa['_id']}")
    end
end

Given('que existem pessoas') do |table|
    table.hashes().each do |pessoa|
        RestClient.post("#{CONFIG['url']}/pessoas", {nome: pessoa[:nome], telefone: pessoa[:telefone], email: pessoa[:email]}.to_json, headers={content_type: :json})
    end
end
  

Given('o usuário acessou o ambiente de pessoas') do
    visit '/#!/pessoas/list'
    # expect(page).to have_current_path('https://alecsandro-imersao-javascript.herokuapp.com/#!/pessoas/list')
    # expect(page).to have_current_path('#{CONFIG['url']}/#!/pessoas/list')
end

Given('digitar {string} no campo nome da pessoa') do |nome|
    find_by_id('nome').set(nome)
end

Given('digitar {string} no campo telefone da pessoa') do |telefone|
    find_by_id('telefone').set(telefone)
end

Given('digitar {string} no campo e-mail da pessoa') do |email|
    find_by_id('email').set(email)
end

Then('deveria exibir {string} na lista de pessoas') do |pessoa|
    expect(page.text).to include pessoa
end

Then('deveria existir {int} pessoas') do |quantidade|
    expect(all('#pessoa').length).to eq quantidade
end

When('clicar no botão com o título {string} da pessoa {string}') do |titulo, nome|
    all('#pessoa').each do |pessoa|
        if pessoa.text.include?(nome)
            pessoa.find("td button[title='#{titulo}']").click
            break
        end
        # pessoa.find("button[title='#{titulo}']").click unless !pessoa.text.include?(nome)
    end
end

Then('deveria exibir {string} no campo nome da pessoa') do |nome|
    expect(find('#nome').value).to eq nome
end

Then('deveria exibir {string} no campo telefone da pessoa') do |telefone|
    expect(find('#telefone').value).to eq telefone
end

Then('deveria exibir {string} no campo e-mail da pessoa') do |email|
    expect(find('#email').value).to eq email
end

Then('não deveria exibir {string} na lista de pessoas') do |nome|
    pessoa_existe = false
    all('#pessoa').each do |pessoa|
        if pessoa.text.include?(nome)
            pessoa_existe = true
            break
        end
        # pessoa.find("button[title='#{titulo}']").click unless !pessoa.text.include?(nome)
    end 
    expect(pessoa_existe).to be false
end