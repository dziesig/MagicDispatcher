class TrackType < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name  :string, :required, :unique
    index :integer, :required, :unique
    timestamps
  end

  has_many :tracks
   
  validates_numericality_of :index
  
  def connects?(from, to)
    IC[self.index][from][to]
  end
  
  def has_connection?(conn)
    IC[index][conn][UL] || IC[index][conn][CL] || IC[index][conn][LL] || IC[index][conn][UR] || IC[index][conn][CR] || IC[index][conn][LR]
  end
  
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end
  
  UL = 0
  CL = 1
  LL = 2
  UR = 3
  CR = 4
  LR = 5
  
  IC_NAMES =
  ['UL','CL','LL','UR','CR','LR']
  
  IC =
  [
    [ # UL     CL     LL     UR     CR     LR <= TO as in  IC[0][FROM][TO]
      [ false, false, false, false, false, false], #UL  F
      [ false, false, false, false, true,  false], #CL  R
      [ false, false, false, false, false, false], #LL  O   Through Track
      [ false, false, false, false, false, false], #UR  M
      [ false, true,  false, false, false, false], #CR
      [ false, false, false, false, false, false], #LR
    ],
    [ # UL     CL     LL     UR     CR     LR <= TO as in  IC[1][FROM][TO]
      [ false, false, false, false, false, false], #UL  F
      [ false, true,  false, false, false, false], #CL  R
      [ false, false, false, false, false, false], #LL  O   Left Entry Stub
      [ false, false, false, false, false, false], #UR  M
      [ false, false, false, false, false, false], #CR
      [ false, false, false, false, false, false], #LR
    ],
    [ # UL     CL     LL     UR     CR     LR <= TO as in  IC[2][FROM][TO]
      [ false, false, false, false, false, false], #UL  F
      [ false, false, false, false, false, false], #CL  R
      [ false, false, false, false, false, false], #LL  O   Right Entry Stub
      [ false, false, false, false, false, false], #UR  M
      [ false, false, false, false, true,  false], #CR
      [ false, false, false, false, false, false], #LR
    ],
    [ # UL     CL     LL     UR     CR     LR <= TO as in  IC[3][FROM][TO]
      [ false, false, false, false, false, false], #UL  F
      [ false, false, false, false, true,  false], #CL  R
      [ false, false, false, false, false, false], #LL  O   Through Yard/Station
      [ false, false, false, false, false, false], #UR  M
      [ false, true,  false, false, false, false], #CR
      [ false, false, false, false, false, false], #LR
    ],
    [ # UL     CL     LL     UR     CR     LR <= TO as in  IC[4][FROM][TO]
      [ false, false, false, false, false, false], #UL  F
      [ false, true,  false, false, false, false], #CL  R
      [ false, false, false, false, false, false], #LL  O   Left Entry Yard/Station
      [ false, false, false, false, false, false], #UR  M
      [ false, false, false, false, false, false], #CR
      [ false, false, false, false, false, false], #LR
    ],
    [ # UL     CL     LL     UR     CR     LR <= TO as in  IC[5][FROM][TO]
      [ false, false, false, false, false, false], #UL  F
      [ false, false, false, false, false, false], #CL  R
      [ false, false, false, false, false, false], #LL  O   Right Entry Yard/Station
      [ false, false, false, false, false, false], #UR  M
      [ false, false, false, false, true,  false], #CR
      [ false, false, false, false, false, false], #LR
    ],
    [ # UL      CL      LL      UR      CR      LR <= TO as in  IC[6][FROM][TO]
      [ false,  false,  false,  false,  false,  false], #UL  F
      [ false,  false,  false,  true,   true,   false], #CL  R
      [ false,  false,  false,  false,  false,  false], #LL  O   Left Entry Right Turnout
      [ false,  true,   false,  false,  false,  false], #UR  M
      [ false,  true,   false,  false,  false,  false], #CR
      [ false,  false,  false,  false,  false,  false], #LR
    ],
    [ # UL      CL      LL      UR      CR      LR <= TO as in  IC[7][FROM][TO]
      [ false,  false,  false,  false,  false,  false], #UL  F
      [ false,  false,  false,  false,  true,   true ], #CL  R
      [ false,  false,  false,  false,  false,  false], #LL  O   Left Entry Left Turnout
      [ false,  false,  false,  false,  false,  false], #UR  M
      [ false,  true,   false,  false,  false,  false], #CR
      [ false,  true,   false,  false,  false,  false], #LR
    ],
    [ # UL      CL      LL      UR      CR      LR <= TO as in  IC[8][FROM][TO]
      [ false,  false,  false,  false,  true,   false], #UL  F
      [ false,  false,  false,  false,  true,   false], #CL  R
      [ false,  false,  false,  false,  false,  false], #LL  O   Right Entry Right Turnout
      [ false,  false,  false,  false,  false,  false], #UR  M
      [ true,   true,   false,  false,  false,  false], #CR
      [ false,  false,  false,  false,  false,  false], #LR
    ],
    [ # UL      CL      LL      UR      CR      LR <= TO as in  IC[9][FROM][TO]
      [ false,  false,  false,  false,  false,  false], #UL  F
      [ false,  false,  false,  false,  true,   false], #CL  R
      [ false,  false,  false,  false,  true,   false], #LL  O   Right Entry Left Turnout
      [ false,  false,  false,  false,  false,  false], #UR  M
      [ false,  true,   true,   false,  false,  false], #CR
      [ false,  false,  false,  false,  false,  false], #LR
    ],
    [ # UL      CL      LL      UR      CR      LR <= TO as in  IC[10][FROM][TO]
      [ false,  false,  false,  true,   false,  true ], #UL  F
      [ false,  false,  false,  false,  false,  false], #CL  R
      [ false,  false,  false,  false,  false,  true ], #LL  O   Right Crossover
      [ true,   false,  false,  false,  false,  false], #UR  M
      [ false,  false,  false,  false,  false,  false], #CR
      [ true,   false,  true,   false,  false,  false], #LR
    ],
    [ # UL      CL      LL      UR      CR      LR <= TO as in  IC[11][FROM][TO]
      [ false,  false,  false,  true,   false,  false], #UL  F
      [ false,  false,  false,  false,  false,  false], #CL  R
      [ false,  false,  false,  true,   false,  false], #LL  O   Left Crossover
      [ true,   false,  true,   false,  false,  false], #UR  M
      [ false,  false,  false,  false,  false,  false], #CR
      [ false,  false,  false,  false,  false,  false], #LR
    ],
    [ # UL      CL      LL      UR      CR      LR <= TO as in  IC[11][FROM][TO]
      [ false,  false,  false,  true,   false,  true ], #UL  F
      [ false,  false,  false,  false,  false,  false], #CL  R
      [ false,  false,  false,  true,   false,  true ], #LL  O   Double Crossover
      [ true,   false,  true,   false,  false,  false], #UR  M
      [ false,  false,  false,  false,  false,  false], #CR
      [ true,   false,  true,   false,  false,  false], #LR
    ],
  ]
  
end
