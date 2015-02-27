require "blatt/fetcher"

module Blatt
  class Wadus; end

  class WadusWithDependency
    attr_reader :dependency

    def initialize(dependency)
      @dependency = dependency
    end
  end

  class WadusDependency; end
end

describe Blatt::Fetcher do
  it "instantiates an object w/o dependencies" do
    fetcher = Blatt::Fetcher.new(tree_without_dependencies)

    expect(fetcher.get("wadus")).to be_a(Blatt::Wadus)
  end

  it "instantiates an object with one dependency" do
    fetcher = Blatt::Fetcher.new(tree_with_dependencies)

    wadus = fetcher.get("wadus")
    expect(wadus).to be_a(Blatt::WadusWithDependency)
    expect(wadus.dependency).to be_a(Blatt::WadusDependency)
  end

  it "instantiates an object with one dependency that has dependencies" do
    fetcher = Blatt::Fetcher.new(tree_with_nested_dependencies)

    wadus = fetcher.get("wadus")
    expect(wadus).to be_a(Blatt::WadusWithDependency)
    expect(wadus.dependency).to be_a(Blatt::WadusWithDependency)
    expect(wadus.dependency.dependency).to be_a(Blatt::WadusDependency)
  end

  it "instantiates an object with a string as a dependency" do
    fetcher = Blatt::Fetcher.new(tree_with_string_dependency)

    wadus = fetcher.get("wadus")
    expect(wadus.dependency).to eq("this is a string")
  end

  it "instantiates an object with an integer as a dependency" do
    fetcher = Blatt::Fetcher.new(tree_with_integer_dependency)

    wadus = fetcher.get("wadus")
    expect(wadus.dependency).to eq(5)
  end

  it "instantiates each object only once" do
    fetcher = Blatt::Fetcher.new(tree_without_dependencies)

    wadus = fetcher.get("wadus")
    expect(fetcher.get("wadus")).to be(wadus)
  end

  def tree_without_dependencies
    {
      wadus: {
        object: "Blatt::Wadus",
        dependencies: []
      }
    }
  end

  def tree_with_dependencies
    {
      wadus: {
        object: "Blatt::WadusWithDependency",
        dependencies: ["wadus_dependency"]
      },
      wadus_dependency: {
        object: "Blatt::WadusDependency",
        dependencies: []
      }
    }
  end

  def tree_with_nested_dependencies
    {
      wadus: {
        object: "Blatt::WadusWithDependency",
        dependencies: ["wadus_dependency"]
      },
      wadus_dependency: {
        object: "Blatt::WadusWithDependency",
        dependencies: ["wadus_dependency_dependency"]
      },
      wadus_dependency_dependency: {
        object: "Blatt::WadusDependency",
        dependencies: []
      }
    }
  end

  def tree_with_string_dependency
    {
      wadus: {
        object: "Blatt::WadusWithDependency",
        dependencies: ["this is a string"]
      }
    }
  end

  def tree_with_integer_dependency
    {
      wadus: {
        object: "Blatt::WadusWithDependency",
        dependencies: [5]
      }
    }
  end
end
