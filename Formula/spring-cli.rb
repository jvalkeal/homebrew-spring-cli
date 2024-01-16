# Generated with JReleaser 1.11.0-SNAPSHOT at 2024-01-16T12:57:39.99417186Z
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  version "0.8.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.1/spring-cli-standalone-0.8.1-linux.x86_64.zip"
    sha256 "0dd4c1813352ab2cc33a94ccaff3b9e7b86c1413b7743a7aa768207a469b2f5e"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.1/spring-cli-standalone-0.8.1-osx.aarch64.zip"
    sha256 "367a84a70fc0794d3700680e8a98b1f02975c19789580e1491043b44a99ee728"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jvalkeal/spring-cli/releases/download/v0.8.1/spring-cli-standalone-0.8.1-osx.x86_64.zip"
    sha256 "6b49229cb9aeced187b9d4d5a34ef30e48cb34b3e0007ab3ba74e93740cbf26a"
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
