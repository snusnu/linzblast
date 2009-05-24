namespace :db do
  
  desc "Import application specific data"
  task :seed => :automigrate do
    
    # users
    
    snusnu = User.create(
      :email                 => 'gamsnjaga@gmail.com',
      :crypted_password      => '1207c09a9daef91cba25525f075d009be093207b',
      :salt                  => '474924f42923b1ee67a27827c36be3ec125831ef'
    )
    
    armitage = User.create(
      :email                 => 'lord.armitage@gmail.com',
      :crypted_password      => 'fa321fca1c3fbc8d91c5753e1aa3ced1af6ba9cf',
      :salt                  => '58efaeaf1f6d85e5c72c807b2772b6f4cafb0d84'
    )
    
    cargoblast = User.create(
      :email                 => 'cargoblast@hotmail.com',
      :crypted_password      => '2d00d5bd365c771067f2af70711b0bf14bc5e8b8',
      :salt                  => '4d0a6015f1638ae1500122a3205b9439a601e04f'
    )
    
    # styles
    
    domblasta = Style.create(
      :name        => 'domblasta',
      :description => 'domblasta',
      :impact      => 10,
      :distortion  => 10,
      :ttl         => 3600
    )
    
    # style_collections
    
    all_styles = StyleCollection.create(
      :name        => 'all we got',
      :description => 'all we got'
    )
    
    StyleCollectionMembership.create(
      :style_collection => all_styles,
      :style => domblasta
    )
    
  end
  
end