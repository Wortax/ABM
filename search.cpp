#include <iostream>
#include <fstream>
#include <vector>
#include <bits/stdc++.h>
#include <dirent.h>

using namespace std;


pair<int, int> find_pep_coord(string txt, string pep)
{
    int found = txt.find(pep);
    int pos = -1;
    while (found != string::npos) {
        pos = found;
        found = txt.find(pep, found + 1);
    }
    pair <int, int> coords;
    if(pos==-1){
        return make_pair(0,0);
    }
    return make_pair(pos*3,(pos+ pep.length())*3);
}

string get_genomic_sequence(int start, int end, string file_path){
    fstream File;
    File.open(file_path, ios::in);
    if (!File) {
        cout<<"File doesn't exist."<<endl;
        return 0;
    }
    string line;
    string genome;
    getline (File, line);
    while (getline (File, line)) {
        genome += line;
    }
    File.close();
    string genomic_sequence = genome.substr(start,abs(start-end));
    return genomic_sequence;
}


pair<int, int> correct_coords(int s, int e, int frame_id, int frame_size){
    if(frame_id ==1 || frame_id ==2){
        s+=frame_id;
        e+=frame_id;
    }else if(frame_id==4 || frame_id==5){
        s = frame_size*3 - (s- (frame_id-3));
        e = frame_size*3 - (e- (frame_id-3));
    }
    return make_pair(s, e);
}


int main () {
    char cwd[PATH_MAX];
    getcwd(cwd, sizeof(cwd));
    fstream File;
    string path = string(cwd);
    path = path.substr(0, path.find_last_of("\\/"));

    DIR *dr;
    struct dirent *en;
    string temp_path = path +"/Temp/";
    dr = opendir(temp_path.c_str()); //open all or present directory
    string filename;
    if (dr) {
        while ((en = readdir(dr)) != NULL)
        {
            string t = en->d_name;
            if(t.length()>3){
                filename = t;
            }
        }
        closedir(dr); //close all directory
    }
    cout<< "Searching "<<filename << endl;

    File.open(path+"/Temp/"+filename, ios::in);
    if (!File) {
        cout<<"Couldn't open Translated file"<<endl;
        return 0;
    }
    string line;
    fstream pep_file;
    pep_file.open(path+"/peptide.txt", ios::in);
    if (!pep_file) {
        cout<<"Couldn't open peptide file"<<endl;
        return 0;
    }
    getline (pep_file, line);
    string pep_seq = line;
    pep_seq.erase(remove(pep_seq.begin(),pep_seq.end(),'\n'), pep_seq.end());
    pep_seq.erase(remove(pep_seq.begin(),pep_seq.end(),' '), pep_seq.end());
    pep_file.close();

    vector<string> frame_list;
    string curr_frame;
    line ="";
    while (getline (File, line)) {
        if(line[0]=='>'){
            frame_list.push_back(curr_frame);
            curr_frame = "";
            continue;
        }
        curr_frame += line;
    }
    File.close();
    frame_list.push_back(curr_frame);
    frame_list.erase(frame_list.begin());


    string frame;
    for (int frame_id = 0; frame_id < frame_list.size(); frame_id++) {
        frame = frame_list.at(frame_id);
        pair<int, int> coords;
        coords = find_pep_coord(frame, pep_seq);
        int start,end;
        start = coords.first;
        end = coords.second;
        if(start==0 && end ==0){
            continue;
        }
        coords = correct_coords(start,end,frame_id, frame.length()-1);
        start = coords.first;
        end = coords.second;

        string genomic_seq = get_genomic_sequence(start, end, path+"/Genome/"+ filename.substr(0,filename.size()-4));
        cout<< filename + "\t" + to_string(start)+"\t"+to_string(end)+"\t"+genomic_seq <<endl;
        fstream output_file;
        output_file.open(path + "/Output/pep_localisation.txt", ios::out);
        output_file << filename + "\t" + to_string(start)+"\t"+to_string(end)+"\t"+genomic_seq ;
        output_file.close();
    }
    return 0;
}
