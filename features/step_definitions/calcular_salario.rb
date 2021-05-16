Dado('o usuário acessou o ambiente para calcular salário líquido e impostos') do
    visit '/#!/salario/salario'
end

Quando('digitar {string} no campo salário bruto') do |salario_bruto|
    find_by_id('salarioBruto').send_keys(salario_bruto)
end

Quando('digitar {string} no campo dependentes') do |dependentes|
    find_by_id('dependentes').send_keys(dependentes)
end

Quando('digitar {string} no campo descontos') do |descontos|
    find_by_id('descontos').send_keys(descontos)
end

Quando(/^aguardar (\d+) segundos?$/) do |segundos|
    sleep segundos
end

Então('deveria exibir {string} no valor do salário bruto') do |salario_bruto|
    expect(find('#resultado').text).to eq salario_bruto
end

Então('deveria exibir {string} no valor do INSS') do |valor_inss|
    expect(all('li[class="list-group-item ng-binding"]')[0].text).to eq valor_inss
end

Então('deveria exibir {string} no valor do IRRF') do |valor_irpf|
    expect(all('li[class="list-group-item ng-binding"]')[1].text).to eq valor_irpf
end

Então('deveria exibir {string} no valor do salário sem impostos') do |salario_sem_impostos|
    expect(all('li[class="list-group-item ng-binding"]')[2].text).to eq salario_sem_impostos
end

Então('deveria exibir {string} no valor do salário líquido') do |salario_liquido|
    expect(all('li[class="list-group-item ng-binding"]')[3].text).to eq salario_liquido
end
