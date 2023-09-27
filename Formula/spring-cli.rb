# Generated with JReleaser 1.8.0 at 2023-09-27T10:52:20.254064498+01:00
class SpringCli < Formula
  desc "Spring Cli"
  homepage "https://github.com/spring-projects-experimental/spring-cli"
  url "https://github.com/jvalkeal/spring-cli/releases/download/v0.7.1/spring-cli-0.7.1.zip"
  version "0.7.1"
  sha256 "c9b0b1ba8c5e2ed445f51c509d8e233b505608f1c45714d821cc3d8f06e7c183"
  license "Apache-2.0"

  depends_on "openjdk@17"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/spring" => "spring"
  end

  test do
    output = shell_output("#{bin}/spring --version")
    assert_match "0.7.1", output
  end
end
