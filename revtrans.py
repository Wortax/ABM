import os
import sys


peptide = str(sys.argv[1])

if "-useU" in sys.argv :
    ARN = True
else :
    ARN= False

dict = {
    "F":"TT[TC]",
    "L":"(TT[AG]|CT[ATCG])",
    "I":"AT[ATC]",
    "M":"ATG",
    "V":"GT[ATCG]",
    "S":"(TC[ATCG]|AG[TC])",
    "P":"CC[ATCG]",
    "T":"AC[ATCG]",
    "A":"GC[ATCG]",
    "Y":"TA[TC]",
    "H":"CA[TC]",
    "Q":"CA[AG]",
    "N":"AA[TC]",
    "K":"AA[AG]",
    "D":"GA[TC]",
    "E":"GA[AG]",
    "C":"TG[TC]",
    "W":"TGG",
    "R":"(CG[ATCG]|AG[AG])",
    "G":"GG[ATCG]"
}
regex=""
for i in peptide :
    regex+= dict[i]
result = "echo \""+ regex+"\""
if ARN :
    result =result.replace("T","U")

os.system(result)
