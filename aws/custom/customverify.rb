module MagicBeansVerifier
  def has_magic_beans(sauce)
    @commands << '[ -z "`echo $' + sauce + '`"]'
  end
end

module MD5Comparison
  def matches_my_local(localfile, remotefile, mode=nil)
    raise "Couldn't find local file #{localfile}" unless ::File.exists?(localfile)
    local = `md5sum #{localfile}`.split.first
    @commands << %{[ "X$(md5sum #{remotefile}| awk \'{print $1}\')" = "X#{local}" ]}
  end
end

Sprinkle::Verify.register(MagicBeansVerifier)
Sprinkle::Verify.register(MD5Comparison)
