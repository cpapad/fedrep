class Kpi < Struct.new(:name, :type, :weight, :score, :rsrv)
    def initialize
      self.name = ["Usability", "Sup Satisfaction", "Doc Readability", "Operability", "Availability"]
      self.type = ["ling", "ling", "ling", "ling", "num"]
      self.weight = [ 0.25, 0.25, 0.25, 0.25, 1.0]
      self.score = Array.new(5)
      self.rsrv = Array.new(5)
    end
    




    def self.rsrv_numeric(rating)
        attr_vals = Array.new(2)
        attr_vals[0] = 1.00
        attr_vals[1] = 0.01*credibility(rating,2)
        #attr_vals[1] = 1.00
        a = Array.new(2)
        b = Array.new(2)
        rsrm = Array.new
        rsrm.push a
        rsrm.push b
        #puts rsrm
        #puts rsrm.inspect
        s_r=[]
        for i in 0..1
            s_r[i] = 0
            for j in 0..1           #rsrm table creation with evaluation divisions for bigger best values
                rsrm[i][j] = attr_vals[i]/attr_vals[j] #if smaller the best (latency) attr_vals[j]/attr_vals[i]
                s_r[i] += rsrm[i][j]  #sum of rows
            end
        end
        s2 = 1 / (s_r[0]+s_r[1])
        s_c=[]
        for j in 0..1
            s_c[j] = 0
            for i in 0..1
                s_c[j] += rsrm [i][j] #sum of columns
            end
        end
        rsrv = []
        for i in 0..1
            rsrv[i] = s_c[i]*s2
        end
        
        rsrv
        
    end

    
    def self.f_rsrv(rating)
        sum = Fuzzy.new(0.0, 0.0, 0.0)
        s = Array.new(2)
        fuzzy_comp = Array.new(2)
        fuzzy_comp[0] = Fuzzy.ling_tf("PERFECT")
        puts fuzzy_comp[0]
        #fuzzy_comp[1] = Fuzzy.ling_tf(rating)
        fuzzy_comp[1] = rating
        puts fuzzy_comp[1]
        rsrm = Array.new(2) {Array.new(2)}
        
        for i in 0..1
            for j in 0..1
                if i == j
                    rsrm[i][j] = Fuzzy.new(1.0, 1.0, 1.0)
                else
                    rsrm[i][j] = Fuzzy.div(fuzzy_comp[i],fuzzy_comp[j])
                end
            end
        end
        
        
        
        for i in 0..1 do
            s[i] = Fuzzy.new(0.0, 0.0, 0.0)
        end
        
        for i in 0..1
            for j in 0..1
                s[i] = Fuzzy.add(s[i], rsrm[i][j])
                sum = Fuzzy.add(sum, rsrm[i][j])
            end
        end
        
        temp = Fuzzy.new(1.0, 1.0, 1.0)
        den = Fuzzy.div(temp, sum)
        
        ds = Array.new(2)
        
        possib = Array.new(2) {Array.new(2)}
        
        for i in 0..1
            ds[i] = Fuzzy.mul(s[i], den)
        end
         
        for i in 0..1
            for j in 0..1
                if ds[i].m >= ds[j].m
                    possib[i][j] = 1
                elsif ds[i].m <= ds[j].m &&  ds[j].l <= ds[i].u
                    possib[i][j] = (ds[j].l-ds[i].u)/((ds[i].m-ds[i].u)-(ds[j].m-ds[j].l))
                else
                    possib[i][j] = 0
                end
            end
        end
        
        d = possib.min
        dsum = d[0] + d[1]
        rsrv = []
        for i in 0..1
            rsrv[i] = d[i]/dsum
            puts "PRINTING RSRV INPUT"
            puts rsrv[i]
        end
        #rsrv.reverse
        rsrv                 
    end
    
    def self.credibility(o, exp)
        puts o
        sla = 80
        m = 90
        user_exp = exp
        puts (m-sla).abs
        if (m-sla).abs > 10.0   #define threshold for opinion adjustment
            e = (m-sla).abs
        else
            e = 10.0
        end
        
        if e > (m-o).abs
            dc = 1.0
        else
            dc = 10/(m-o).abs
        end
        cred = 0.5    #credibility for testing 
        cred = ((user_exp - 1)*cred + dc)/user_exp #user_Exp -> number of experiments per user 
        puts cred
        if cred < 0.5 && dc!=1
            if m > o 
                o_new = m - e
            else
                o_new = o - e
            end
        else
            o_new = o
        end
        
        o_new
        
    end
    
    def custom_rank
        rsrv_new = Array.new(2, 0)
        for j in 0..1
            for i in 0..3               
                  rsrv_new[j] += self.rsrv[i][j] * self.weight[i]
           end
       end
       puts "RSRV NEW"
       puts rsrv_new.inspect
       rsrm = []
       rsrm << rsrv_new
       rsrm << self.rsrv[4]
       puts "RSRM ARRAY"
       puts rsrm.inspect
       rsrv = Array.new(2, 0)
       weight = []
       weight[0] = 0.2
       weight[1] = 0.8
       for j in 0..1
            puts "ti pollaplasizo"
            puts rsrm[j]
           for i in 0..1
               
                rsrv[j] += rsrm[i][j] * weight[i] #multiply every service with each weight for each testbed
           end
       end
       puts "RSRM WITH WEIGHT"
       puts rsrv.inspect
       rsrv
    end
        
    def self.update_reputation(rank)
        prev = 50
        num = 2
        rep = (prev * (num - 1) + 100 * (rank[0]/rank[1]))/num
        puts rep
    end
    
    def rep_calc
	    puts "YOYYOYOYO"
    end




    #puts credibility(90, 10)

end
