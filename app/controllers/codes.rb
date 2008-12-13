class Codes < Application
  controlling :codes do |c|
    c.belongs_to :code_generation
    c.actions :index
  end
end