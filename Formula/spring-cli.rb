# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-10-12T09:56:52.248052407Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/spring-cli-standalone-0.7.1-linux.x86_64.zip"
    sha256 "d53449c2112189e63a82fbbbe9b828c8d73254af91eeda9bbf1662d03adee1b8"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/spring-cli-standalone-0.7.1-osx.x86_64.zip"
    sha256 "27043a1abf59ff907147bb5da322533196b9abd33dc4678c7aa7006be06cbb4a"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/spring-cli-standalone-0.7.1-osx.x86_64.zip"
    sha256 "27043a1abf59ff907147bb5da322533196b9abd33dc4678c7aa7006be06cbb4a"
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
        MachO.codesign!(dylib) if Hardware::CPU.arm?
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/spring --version")
    assert_match "0.7.1", output
  end
end
