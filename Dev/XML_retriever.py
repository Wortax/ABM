import requests
import os
import re
import time
import threading



id_file = open("sra_acc_id", "r")
id_list = id_file.read().split("\n")






CLEANR = re.compile('<.*?>|&([a-z0-9]+|#[0-9]{1,6}|#x[0-9a-f]{1,6});')
def cleanhtml(raw_html): # Convert XML in HTML format to XML format
  cleantext = re.sub(CLEANR, '', raw_html)
  return cleantext

def download_link(id,file):
  response = requests.get("https://www.ncbi.nlm.nih.gov/sra/" + id + "?report=FullXml")
  txt = response.text
  txt = txt[txt.find("<div class=\"rprt\""):txt.find("class=\"aux\">")] + ">"
  txt = txt.replace("&gt;", "\_/").replace("&lt;", "/_\\")
  cleaned_txt = cleanhtml(txt).replace("\_/", ">").replace("/_\\", "<")
  file.write(cleaned_txt)

def open_file_range_list(file, start, end, url_list):
    for i in range(start,end):
      download_link(url_list[i],file)



###### WIP
max_run = 10000
def multi_thread_file(filename,id_list,start,end,number_thread):
    f = open(filename, "a")
    f.write("<root>")
    pas = round(abs(end-start)/number_thread)
    thread_list = []
    for i in range(0,end,pas):
        thread_list.append(threading.Thread(target=open_file_range_list,args=(f, i, i+pas, id_list,)))
        thread_list[-1].start()

    for i in thread_list:
        i.join()

    f.write("</root>")
    f.close()

for i in range(1,round(len(id_list)/max_run)+1):
    start_time = time.time()

    print((i-1)*max_run,i*max_run)
    multi_thread_file(str(i)+".xml",id_list,(i-1)*max_run,i*max_run,25)
    print(str(i)+" Finished after ",time.time()-start_time)

print("Total time:", time.time() - start_time)
