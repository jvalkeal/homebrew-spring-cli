# Generated with JReleaser 1.10.0-SNAPSHOT at 2023-11-17T14:07:48.919456102Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.7.5"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.5/spring-cli-standalone-0.7.5-linux.x86_64.zip"
    sha256 "f538f0bcea9f871ddd7dd992d4df51e211bbcc64a45eb6f811d7b3cc568d5e38"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.5/spring-cli-standalone-0.7.5-osx.aarch64.zip"
    sha256 "948f4981cf9916b0582c3d01720591d34ef3c2133b367020393c8386925be8ba"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.5/spring-cli-standalone-0.7.5-osx.x86_64.zip"
    sha256 "01f17502139ef73eaba9229d03a3df9ba46679ebdcc7512cfe2ba984fb76bac1"
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
    assert_match "0.7.5", output
  end
end
