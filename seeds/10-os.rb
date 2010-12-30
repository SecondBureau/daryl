{ 'wi(n|ndows)?' => 'windows',
  'linux[ /\-]([a-z0-9._]{1,10})' => 'linux',
  'linux' => 'linux',
  'Mac[ _]?OS[ _]?X[ /]([0-9.]{1,10})' => 'macosx',
  'Mac[ _]?OS[ _]?X' => 'macosx',
  'Mac 10.([0-9.]{1,10})' => 'macosx',
  'Mac(_Power|intosh.+P)PC' => 'macppc',
  'beos[ a-z]*([0-9.]{1,10})' => 'beos',
  'beos' => 'beos',
  'fedora' => 'fedora',
  'free[ \-]?bsd[ /]([a-z0-9._]{1,10})' => 'freebsd',
  'free[ \-]?bsd' => 'freebsd',
  'open[ \-]?bsd[ /]([a-z0-9._]{1,10})' => 'openbsd',
  'open[ \-]?bsd' => 'openbsd',
  'PCLinuxOS[ /]?([0-9.]{1,10})' => 'pclinux',
  'ubuntu' => 'ubuntu'
}.each do |signature, name| 
  os = Os.first(:signature => signature) || Os.new
  os.signature = signature
  os.name = name
  os.save
end      
        

puts Os.all.inspect
