# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-10-11T17:03:16.966490885Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/spring-cli-standalone-0.7.1-linux.x86_64.zip"
    sha256 "7fd4eca67c1b3148abb1277e4a2ee8aa6e6c779d915e991738225d99ae6c9d9e"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring-cli-standalone" => "spring-cli-standalone"
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
    output = shell_output("#{bin}/spring-cli-standalone --version")
    assert_match "0.7.1", output
  end
end
