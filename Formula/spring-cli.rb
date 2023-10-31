# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-10-31T16:38:11.570083397Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.3"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.3/spring-cli-standalone-0.7.3-linux.x86_64.zip"
    sha256 "04f7236c0ba40506e74fc0fe683047fbc67191f84589efcb137bee09370edea3"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.3/spring-cli-standalone-0.7.3-osx.x86_64.zip"
    sha256 "ebc90dd150ff7da95b39a99a6333caf6670719103549c385388d68167e42802c"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.3/spring-cli-standalone-0.7.3-osx.x86_64.zip"
    sha256 "ebc90dd150ff7da95b39a99a6333caf6670719103549c385388d68167e42802c"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib)
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/spring --version")
    assert_match "0.7.3", output
  end
end
