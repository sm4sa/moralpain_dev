import ..implementation.collection_list
import tactic.cache

open collection

def ns := [1,2,3]


#eval collection.has_collection.member ns 1  -- expect tt
#eval collection.has_collection.member ns 5  -- expect ff


def insert_0 (
  l : list nat) 
  [collection.has_collection list] : 
  list nat :=
collection.has_collection.insert l 0

#reduce insert_0 ns   -- evaluates to [0,1,2,3]

/-
TODO: Why? Expression (insert_0 ns) not reducing in this context
-/ 
example : (insert_0 ns) = [0,1,2,3] := 
begin
  exact rfl,    -- ⊢ insert_0 ns = [0, 1, 2, 3]
end


