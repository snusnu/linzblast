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
    
    # walls
    
    Wall.create(
      :name => 'nights',
      :description => 'Linz',
      :access_restricted => true,
      :wall_image => File.new("#{Merb.root}/public/linzblast/walls/linz_bridge_night.jpg")
    )
    
    Wall.create(
      :name => 'roofs',
      :description => 'Linz',
      :access_restricted => true,
      :wall_image => File.new("#{Merb.root}/public/linzblast/walls/linz_center_roof.jpg")
    )
    
    Wall.create(
      :name => 'main',
      :description => 'Linz',
      :access_restricted => true,
      :wall_image => File.new("#{Merb.root}/public/linzblast/walls/linz_main_square_bw.jpg")
    )
    
    Wall.create(
      :name => 'bridge day',
      :description => 'Linz',
      :access_restricted => true,
      :wall_image => File.new("#{Merb.root}/public/linzblast/walls/linz_bridge_day.jpg")
    )
    
    Wall.create(
      :name => 'brucknerhaus',
      :description => 'Linz',
      :access_restricted => true,
      :wall_image => File.new("#{Merb.root}/public/linzblast/walls/linz_brucknerhaus.jpg")
    )
    
    Wall.create(
      :name => 'churches',
      :description => 'Linz',
      :access_restricted => true,
      :wall_image => File.new("#{Merb.root}/public/linzblast/walls/linz_churches.jpg")
    )
    
    Wall.create(
      :name => 'hauptplatz day',
      :description => 'Linz',
      :access_restricted => true,
      :wall_image => File.new("#{Merb.root}/public/linzblast/walls/linz_hauptplatz_day.jpg")
    )
    
    Wall.create(
      :name => 'lentia',
      :description => 'Linz',
      :access_restricted => true,
      :wall_image => File.new("#{Merb.root}/public/linzblast/walls/linz_lentia.jpg")
    )

     Wall.create(
      :name => 'rudolf underground',
      :description => 'Linz',
      :access_restricted => true,
      :wall_image => File.new("#{Merb.root}/public/linzblast/walls/linz_rudolf_underground.jpg")
    )
    
     Wall.create(
      :name => 'ars night',
      :description => 'Linz',
      :access_restricted => true,
      :wall_image => File.new("#{Merb.root}/public/linzblast/walls/linz_aec_night.jpg")
    )
    
     Wall.create(
      :name => 'steel dawn',
      :description => 'Linz',
      :access_restricted => true,
      :wall_image => File.new("#{Merb.root}/public/linzblast/walls/linz_voest_dawn.jpg")
    )
    
     Wall.create(
      :name => 'steel night',
      :description => 'Linz',
      :access_restricted => true,
      :wall_image => File.new("#{Merb.root}/public/linzblast/walls/linz_voest_night.jpg")
    )

    # styles
    
    aec = Style.create(
      :name            => 'aec-transistor-schaltbild',
      :description     => 'domblasta',
      :type            => 'rAECer',
      :series          => 'ledmonster',
      :manufacturer    => 'WAFTL & KUNST',
      :range           => '40 caves',
      :impact          => 10,
      :distortion      => 30,
      :ttl             => 3600,
      :style_image           => File.new("#{Merb.root}/public/linzblast/weapons_big/aec.png"),
      :style_symbol_image    => File.new("#{Merb.root}/public/linzblast/weapons_small/aec.png"),
      :style_crosshair_image => File.new("#{Merb.root}/public/linzblast/crosshairs/aec.png")
    )
    
    dom = Style.create(
      :name            => 'neuer dom - bischofsmütze',
      :description     => 'domblaster',
      :type            => 'domblaster',
      :series          => 'holymary',
      :manufacturer    => 'VATKINSON',
      :range           => '8 emporen',
      :impact          => 10,
      :distortion      => 30,
      :ttl             => 3600,
      :style_image           => File.new("#{Merb.root}/public/linzblast/weapons_big/dom.png"),
      :style_symbol_image    => File.new("#{Merb.root}/public/linzblast/weapons_small/dom.png"),
      :style_crosshair_image => File.new("#{Merb.root}/public/linzblast/crosshairs/mitra.png")
    )
    
    bruckner = Style.create(
      :name            => 'brucknerhaus - brucknerkonterfei',
      :description     => 'brucknerhaus',
      :type            => 'brucknerhaubitze',
      :series          => 'donaulauf',
      :manufacturer    => 'ANATOL BRUCKNOV',
      :range           => '19 kulturmeilen',
      :impact          => 10,
      :distortion      => 30,
      :ttl             => 3600,
      :style_image           => File.new("#{Merb.root}/public/linzblast/weapons_big/bruckner.png"),
      :style_symbol_image    => File.new("#{Merb.root}/public/linzblast/weapons_small/bruckner.png"),
      :style_crosshair_image => File.new("#{Merb.root}/public/linzblast/crosshairs/bruckner.png")
    )
    
    schloss = Style.create(
      :name            => 'schlossmuseum - stadtwappen',
      :description     => 'schlossmuseum',
      :type            => 'dobuschkov',
      :series          => 'nordflügel',
      :manufacturer    => 'V.E.R.WALTER',
      :range           => '290 amtswege',
      :impact          => 10,
      :distortion      => 30,
      :ttl             => 3600,
      :style_image           => File.new("#{Merb.root}/public/linzblast/weapons_big/schloss.png"),
      :style_symbol_image    => File.new("#{Merb.root}/public/linzblast/weapons_small/schloss.png"),
      :style_crosshair_image => File.new("#{Merb.root}/public/linzblast/crosshairs/wappen.png")
    )
    
    sparka = Style.create(
      :name            => 'sparkasse - lentia',
      :description     => 'sparka',
      :type            => 'sparka',
      :series          => 'blueblasta',
      :manufacturer    => 'AEG & ZINS',
      :range           => '69 prozent',
      :impact          => 10,
      :distortion      => 30,
      :ttl             => 3600,
      :style_image           => File.new("#{Merb.root}/public/linzblast/weapons_big/sparka.png"),
      :style_symbol_image    => File.new("#{Merb.root}/public/linzblast/weapons_small/sparka.png"),
      :style_crosshair_image => File.new("#{Merb.root}/public/linzblast/crosshairs/sparka.png")
    )
    
    termilator = Style.create(
      :name            => 'bahnhofsterminal - wissensturm',
      :description     => 'termilator',
      :type            => 'termilator',
      :series          => 'endstation',
      :manufacturer    => 'KNARRINGER',
      :range           => '960 sumsis',
      :impact          => 10,
      :distortion      => 30,
      :ttl             => 3600,
      :style_image           => File.new("#{Merb.root}/public/linzblast/weapons_big/termilator.png"),
      :style_symbol_image    => File.new("#{Merb.root}/public/linzblast/weapons_small/termilator.png"),
      :style_crosshair_image => File.new("#{Merb.root}/public/linzblast/crosshairs/raika.png")
    )
    
    
    # style_collections
    
    all_styles = StyleCollection.create(
      :name        => 'all we got',
      :description => 'all we got'
    )
    
    StyleCollectionMembership.create(
      :style_collection => all_styles,
      :style => aec
    )
    
    StyleCollectionMembership.create(
      :style_collection => all_styles,
      :style => dom
    )
    
    StyleCollectionMembership.create(
      :style_collection => all_styles,
      :style => bruckner
    )
    
    StyleCollectionMembership.create(
      :style_collection => all_styles,
      :style => sparka
    )
    
    StyleCollectionMembership.create(
      :style_collection => all_styles,
      :style => termilator
    )
    
    StyleCollectionMembership.create(
      :style_collection => all_styles,
      :style => schloss
    )
    
    # codes
    
    CodeGeneration.create(
      :user => snusnu,
      :style_collection => all_styles,
      :amount => 50,
      :nr_of_posts => 10
    )
    
  end
  
end