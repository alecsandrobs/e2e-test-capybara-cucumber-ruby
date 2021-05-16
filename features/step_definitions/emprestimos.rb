Given('que não existem empréstimos') do
    teste = RestClient.get("#{CONFIG['url']}/emprestimos")
    # teste = RestClient.get('#{CONFIG['url']}/emprestimos', headers={content_type: :json})

    emprestimos = JSON.parse(teste.body)

    emprestimos.each do |emprestimo|
        RestClient.delete("#{CONFIG['url']}/emprestimos/#{emprestimo['_id']}")
    end
end

Given('que existem empréstimos') do |emprestimos|
    emprestimos.hashes().each do |emprestimo|
        pessoas = RestClient.get("#{CONFIG['url']}/pessoas?filter={\"nome\":\"#{emprestimo['pessoa']}\"}").body
        pessoa = JSON.parse(pessoas)[0]
        itens = JSON.parse(emprestimo[:itens])
        emp = {tipo: emprestimo[:tipo], dataEmprestimo: emprestimo[:dataEmprestimo], situacao: emprestimo[:situacao], dataDevolucao: emprestimo[:dataDevolucao], pessoa: pessoa, observacoes: emprestimo[:observacoes], itens: itens}
        # RestClient.post("#{CONFIG['url']}/emprestimos", {tipo: emprestimo[:tipo], dataEmprestimo: emprestimo[:dataEmprestimo], situacao: emprestimo[:situacao], dataDevolucao: emprestimo[:dataDevolucao], pessoa: pessoa, observacoes: emprestimo['observacoes'], itens: itens}.to_json, headers={content_type: :json})
        RestClient.post("#{CONFIG['url']}/emprestimos", emp.to_json, headers={content_type: :json})
    end
end

Given('o usuário acessou o menu empréstimos') do
    visit '/#!/emprestimos/list'
end

When('selecionar {string} no campo tipo do empréstimo') do |tipo|
    aguardar_elemento_presente('#tipo', 30)
    select tipo, from: 'tipo'
end

When('digitar {string} no campo data do empréstimo') do |data|
  find_by_id('dataEmprestimo').set(data)
end

When('selecionar {string} no campo situação do empréstimo') do |situacao|
    select situacao, from: 'situacao'
end

When('digitar {string} no campo data de devolução do empréstimo') do |data|
    find_by_id('dataDevolucao').send_keys(data)
end

When('selecionar {string} no campo pessoa do empréstimo') do |pessoa|
    select pessoa, from: 'pessoa'
end

When('digitar {string} no campo observações do empréstimo') do |observacoes|
    find_by_id('observacoes').set(observacoes)
end

When('digitar {string} no campo código do item') do |codigo|
    find_by_id('codigo-item').set(codigo)
end

When('digitar {string} no campo descrição do item') do |descricao|
    find_by_id('descricao').set(descricao)
end

When('digitar {string} no campo quantidade do item') do |quantidade|
    find_by_id('quantidade').set(quantidade)
end

When('digitar {string} no campo preço do item') do |preco|
    find_by_id('preco').set(preco)
end

When(/^adicionar os itens no empréstimos "(.*?)"$/) do |itens|
    JSON.parse(itens).each do |item|
        steps %Q{
            When clicar no botão com o texto "Item"
            And aguardar 1 segundo
        }
        aguardar_elemento_presente('#codigo-item', 30)
        steps %Q{
            When digitar "#{item['codigo']}" no campo código do item
            When digitar "#{item['descricao']}" no campo descrição do item
            When digitar "#{item['quantidade']}" no campo quantidade do item
            When digitar "#{item['preco']}" no campo preço do item
        }
        # all('i[class="fa fa-save"]')[1].click
        # all('i.fa.fa-save')[1].click
        find_by_id('salvar-item').click
    end
end

Then('deveria existir {int} itens do empréstimo') do |quantidade|
    expect(all('tr[ng-repeat="item in vm.emprestimo.itens"]').length).to eq quantidade
end

Then('deveria exibir {string} na lista de itens do empréstimo') do |itens|
    found = false
    # all('tr[ng-repeat="item in vm.emprestimo.itens"]').each do |item|
    all('#item').each do |item|
        if itens.include?(item.text) 
            found = true
            break
        end
    end
    # expect(page.text).to include itens
    expect(found).to be true
end

Then('deveria exibir {string} na linha {int} da lista de itens do empréstimo') do |item, linha|
    expect(all('#item')[linha-1].text).to eq item
    # expect(all('tr[ng-repeat="item in vm.emprestimo.itens"]')[linha-1].text).to eq item
end

Then('deveria existir {int} empréstimos') do |quantidade|
    # expect(all('tr[ng-repeat="item in vm.registros | orderBy : \"dataEmprestimo\""]').length).to eq quantidade
    expect(all('#emprestimo').length).to eq quantidade
end

Then('deveria exibir {string} na lista de empréstimos') do |emprestimo|
    expect(page.text).to include emprestimo
end

Then('não deveria exibir {string} na lista de empréstimos') do |emprestimo|
    expect(page.text).to_not include emprestimo
end

Then('deveria exibir {string} na linha {int} da lista de empréstimos') do |emprestimo, linha|
    # expect(all('tr[ng-repeat="item in vm.emprestimo"]')[linha-1].text).to eq emprestimo
    expect(all('#emprestimo')[linha-1].text).to include emprestimo
end

When('clicar no botão com o título {string} do empréstimo {string}') do |titulo, emprestimo|
    all('#emprestimo').each do |emp|
        if emp.text.include?(emprestimo)
            emp.find("td button[title='#{titulo}']").click
            aguardar_elemento_presente('#tipo', 30) if titulo.eql?('Editar')
            break
        end
        # pessoa.find("button[title='#{titulo}']").click unless !pessoa.text.include?(nome)
    end
end

When('deveria exibir {string} no campo tipo do empréstimo') do |tipo|
    expect(find_by_id('tipo').find('option[selected="selected"]').text).to eq tipo
end

When('deveria exibir {string} no campo data do empréstimo') do |data|
    expect(find_by_id('dataEmprestimo').value).to eq data
end

When('deveria exibir {string} no campo situação do empréstimo') do |situacao|
    expect(find_by_id('situacao').find('option[selected="selected"]').text).to eq situacao
end

When('deveria exibir {string} no campo data de devolução do empréstimo') do |data|
    expect(find_by_id('dataDevolucao').value).to eq data
end

When('deveria exibir {string} no campo pessoa do empréstimo') do |pessoa|
    expect(find_by_id('pessoa').find('option[selected="selected"]').text).to eq pessoa
end

When('deveria exibir {string} no campo observações do empréstimo') do |observacoes|
    expect(find('#observacoes').value).to eq observacoes
end

When('clicar no botão com o título {string} do item {string}') do |titulo,item|
    all('#item').each do |it|
        if it.text.include?(item)
            it.find("td button[title='#{titulo}']").click
            aguardar_elemento_presente('#codigo-item', 30)
            break
        end
    end
end
When('deveria exibir {string} no campo código do item') do |codigo|
    expect(find_by_id('codigo-item').value).to eq codigo
end
When('deveria exibir {string} no campo descrição do item') do |descricao|
    expect(find_by_id('descricao').value).to eq descricao
end
When('deveria exibir {string} no campo quantidade do item') do |quantidade|
    expect(find_by_id('quantidade').value).to eq quantidade
end
When('deveria exibir {string} no campo preço do item') do |preco|
    expect(find_by_id('preco').value).to eq preco
end

Then(/^deveria exibir "(.*?)" nos campos itens no empréstimos$/) do |itens|
    return unless itens
    JSON.parse(itens).each do |item|
        steps %Q{
            When clicar no botão com o título "Editar" do item "#{item['descricao']}"
            When deveria exibir "#{item['codigo']}" no campo código do item
            When deveria exibir "#{item['descricao']}" no campo descrição do item
            When deveria exibir "#{item['quantidade']}" no campo quantidade do item
            When deveria exibir "#{item['preco']}" no campo preço do item
        }
        find_by_id('cancelar-item').click
    end
end

def aguardar_elemento_presente(elemento, tempo = 30)
    Selenium::WebDriver::Wait.new(:timeout => tempo).until do
      all(elemento).length > 0
    end
    all(elemento)[0]
end