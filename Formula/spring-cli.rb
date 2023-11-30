# Generated with JReleaser 1.10.0-SNAPSHOT at 2023-11-30T09:45:59.830654191Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.8.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.0/spring-cli-standalone-0.8.0-linux.x86_64.zip"
    sha256 "85206e495ef1b290aa44c5b88da62f31b520daae0eb623d1ce8a4aa73b5655e7"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.0/spring-cli-standalone-0.8.0-osx.aarch64.zip"
    sha256 "08af3c7565938baa4aa7b3f6a59dd7b39e51c6c5eb2d7428f7c88d01bf7764c6"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.0/spring-cli-standalone-0.8.0-osx.x86_64.zip"
    sha256 "5e056f92c0d6c9748f851cc269e7a026e622fc27c0afd945db040b0f238c1c53"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
    bash_completion.install Dir["#{libexec}/completion/bash/spring"]
    zsh_completion.install Dir["#{libexec}/completion/zsh/_spring"]
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
    assert_match "0.8.0", output
  end
end
