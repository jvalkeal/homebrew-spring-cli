# Generated with JReleaser 1.10.0-SNAPSHOT at 2023-11-18T08:25:44.341715092Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.6"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.6/spring-cli-standalone-0.7.6-linux.x86_64.zip"
    sha256 "891620fedbfd6fa671e388a988b12382a4ad665a1ab7fd18461c6f522fac087d"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.6/spring-cli-standalone-0.7.6-osx.aarch64.zip"
    sha256 "6344872a9981a13cdcfe35c67256a6bb76a29879ef1ef1b4b9431a87891c01b5"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.6/spring-cli-standalone-0.7.6-osx.x86_64.zip"
    sha256 "7e9f5d45ba53864df91b7728bc459188a93d0aac88dd84cff2d92bd2c34cb28a"
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
