# Generated with JReleaser 1.10.0-SNAPSHOT at 2023-11-09T12:51:07.841858447Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.6"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.6/spring-cli-standalone-0.7.6-linux.x86_64.zip"
    sha256 "c53c39928ea1035e622613df15ad046cb0db306145de91b16420209ae64beb93"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.6/spring-cli-standalone-0.7.6-osx.aarch64.zip"
    sha256 "0ef11d855b1d6b22c19b8ed97accaef1910c6c96d474286392771c7222f0f9a8"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.6/spring-cli-standalone-0.7.6-osx.x86_64.zip"
    sha256 "5da56ebcd2d1f6a07698766932da19d9540dfb6f74372ceb2c7ee6e24361ea31"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
    bash_completion.install Dir["#{libexec}/completion/bash/spring"]
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
    assert_match "0.7.6", output
  end
end
