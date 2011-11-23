module ApplicationHelper
  
  class RailroadBranchSection
    attr_reader :railroad, :branch, :section
    
    def railroad=(railroad)
      @railroad=railroad
      if railroad.nil? || no_railroads?
        @branch=nil
        @section=nil
      end
    end
    
    def branch=(branch)
      @branch=branch
      if branch.nil?
        @section=nil
      end
    end
    
    def section=(section)
      @section=section
    end
    
    def railroad_name
      if no_railroads?
        'Please add a Railroad'
      else
        if @railroad.nil? || !get_railroad
          'No Railroad Selected'
        else
          get_railroad.name
        end
      end
    end
    
    def branch_name 
      if no_railroads?
        'Please add a Railroad'
      elsif !railroad_ok?
        'Please select a Railroad'
      elsif no_branches?
        'Please add a Branch'
      elsif !branch_ok?
        'Please select a Branch'
      else
        get_branch.name
      end
    end
    
    def section_name
      if no_railroads?
        'Please add a Railroad'
      elsif !railroad_ok?
        'Please select a Railroad'
      elsif no_branches?
        'Please add a Branch'
      elsif !branch_ok?
        'Please select a Branch'
      elsif no_sections?
        'Please add a Section'
      elsif !section_ok?
        'Please select a Section'
      else
        get_section.name
      end
    end
      
    def railroad_ok?
      !get_railroad.nil?
      # result = true
      # if no_railroads
      #   result = false
      # else
      #   if @railroad.nil? || !Railroad.first(@railroad)
      #     result = false
      #   end
      # end
      # result
    end
      
    def branch_ok?
      !get_branch.nil?
    end
    
    def section_ok?
      !get_section.nil?
    end
        
    private
    
    def no_railroads?
      result = Railroad.count == 0
      if result
        railroad = nil
      end
      result
    end
    
    def no_branches?
      # result = Branch.find(:all,:conditions=>"railroad_id = #{@railroad}").count == 0
      begin
        result = Railroad.find(@railroad).branches.count == 0
      rescue
        result = true
      end
      if result
        branch = nil
      end
      result
    end
    
    def no_sections?
      begin
        result = Railroad.find(@railroad).branches.find(@branch).sections.count == 0
      rescue
        result = true
      end
      if result
        branch = nil
        section = nil
      end
      result
    end
    
    def get_railroad
      Railroad.find(@railroad)
    rescue
      nil
    end
    
    def get_branch
      Railroad.find(@railroad).branches.find(@branch)
    rescue
      @branch = nil
    end
    
    def get_section
      Railroad.find(@railroad).branches.find(@branch).sections.find(@section)
    rescue
      @section = nil
    end
      
    
  end
        
end
