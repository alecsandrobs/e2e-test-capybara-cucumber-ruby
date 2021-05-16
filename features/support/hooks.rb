Before do |scenario|
    @scenario_name = scenario.name
end

AfterStep do |scenario|
    attach(salvar_imagem(@scenario_name), 'image/png') if !scenario
end

After do |scenario|
    attach(salvar_imagem(scenario.name), 'image/png') if scenario.failed?
end

def salvar_imagem(nome_image = "imagem")
    caminho_imagem = File.join(FileUtils.pwd(), "report")
    FileUtils.makedirs(caminho_imagem)
    file_name = caminho_imagem + "/#{nome_image}.png".tr(' ', '_').downcase
    page.save_screenshot(file_name)
    file = File.open(file_name)
    Allure.add_attachment(name: file_name, source: file, type: Allure::ContentType::PNG, test_case: true)
    return file
end