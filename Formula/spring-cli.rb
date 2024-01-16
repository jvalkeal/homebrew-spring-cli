# Generated with JReleaser 1.11.0-SNAPSHOT at 2024-01-16T10:10:31.816425698Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.8.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.1/spring-cli-standalone-0.8.1-linux.x86_64.zip"
    sha256 "8a2cab5e05eb36670bc1e3c92f699902d9209f67a4f447a167e4ad19140fbaf8"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.1/spring-cli-standalone-0.8.1-osx.aarch64.zip"
    sha256 "4b1ace34fb7b3fac4d14e95d2d0ba3f1b43fe6da69004f7d0382a5f4faff2d00"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.1/spring-cli-standalone-0.8.1-osx.x86_64.zip"
    sha256 "103fb7c8521614be3a2149ec87f659390cbc5a900e487e74a18f045a4148652a"
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
    assert_match "0.8.1", output
  end
end
