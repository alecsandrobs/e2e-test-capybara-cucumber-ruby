Then('deveria exibir a mensagem {string}') do |mensagem|
    expect(find_by_id('swal2-title').text).to eq mensagem
end