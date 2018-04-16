#!/usr/bin/python

from optparse import OptionParser
import csv
import os
import sys
import re

def test_list_to_testcases(test_list, bmark_bin_prefix):
    testcases = ''
    for test in test_list:
        #Prefix the path name to the first element of the testcase
        testcases = testcases+bmark_bin_prefix+'+'.join(test)+' \\\n'
    return testcases

def tokenize_csv(csv_file):
    token_list = []
    try:
        f = open(csv_file, 'r')
        reader = csv.reader(f)
        token_list = list(reader)
    except:
        e = sys.exc_info()[0]
        print("Error opening/parsing +"+csv_file+" "+str(e))
        #sys.exit(1)
    token_list.pop(0) # Remove the header row
    token_list = [item for item in token_list if not re.match('#.*',item[0])]
    return token_list

# Return a hash from space separated simpoints/weights file
def ssv_to_hash(file_path, key=0):
    token_hash = {}
    try:
        with open(file_path, 'r') as f:
            for line in f:
                tokens = list(line.strip().split())
                token_hash[tokens[key]] = tokens[:key] + tokens[key+1:]
    except:
        e = sys.exc_info()[0]
        print("Error opening/parsing +"+file_path+" "+str(e))
        #sys.exit(1)

    return token_hash

def tokens_to_csv(file_name, tokens, header):
    with open(file_name,'w') as out:
        csv_out=csv.writer(out)
        csv_out.writerow(header)
        for row in tokens:
            csv_out.writerow(row)

# Append the bmark base path to the bamrk name after
# obtaining the correct benchmark name for a giveb test
def get_test_name(chkpt_name):
    return '.'.join(chkpt_name.split('.')[:2])

# Append the bmark base path to the bamrk name after
# obtaining the correct benchmark name for a giveb test
def get_skip_amt(chkpt_name):
    return chkpt_name.split('.')[2]

# Append the bmark base path to the bamrk name after
# obtaining the correct benchmark name for a giveb test
def get_bmark_name(test_name):

    bmark = test_name

    # Find out the benchmark name for tests which do not
    # match the benchmark name
    bmark_multi_test_list = [
                '401.bzip2',
                '657.xz',
                '602.gcc',
                '600.perlbench',
                '603.bwaves',
            ]
    match = re.match(r"(\d+\.[a-zA-Z0-9]+)(_s)*.*_(test|ref)", test_name)
    speed = ""
    if match.group(2): speed = match.group(2)
    if match.group(1) in  bmark_multi_test_list:
        bmark = match.group(1)+speed+'_'+match.group(3)

    return bmark

# Returns a hash of per-benchmark simpoints with weights and corresponding skip amts.
def create_testcases_from_simpoint(smpt_dir, num_chkpt, bmark_bin_prefix):
    all_tests = os.listdir(smpt_dir)
    test_list = []
    for test_name in all_tests:
        bmark_run_path = smpt_dir+'/'+test_name
        bmark_name = get_bmark_name(test_name)
        smpt_hash = ssv_to_hash(bmark_run_path+'/simpoints', key=1)
        weight_hash = ssv_to_hash(bmark_run_path+'/weights', key=1)
        # This is a lost of tuples (skip,weight) sorted in the order of
        # decreasing weights
        sorted_smpts = list(sorted(weight_hash.iteritems(), key=lambda (k,v): (v,k), reverse=True))
        # Create tests for the specified number of highest weighted checkpoints
        for i in range(0,num_chkpt):
            if len(sorted_smpts) > i:
                sid = sorted_smpts[i][0]
                # Add to the test list, the benchmark path, name, skip amt and
                # weight
                test_list.append([bmark_name,test_name,smpt_hash[sid][0],"{0:.2f}".format(float(weight_hash[sid][0]))])
    # Sorth the testlist by bmark name
    test_list = sorted(test_list, key=lambda test: test[0])
    header = ['bmark_name','test_name','skip_amt','weight']
    tokens_to_csv('tests_from_simpoint.csv', test_list, header)
    return test_list_to_testcases(test_list, bmark_bin_prefix)

# Returns a hash of per-benchmark simpoints with weights and corresponding skip amts.
def create_testcases_from_checkpoint(chkpt_dir, num_chkpt, bmark_bin_prefix):
    all_chkpts = os.listdir(chkpt_dir)
    test_list = []
    for chkpt_name in all_chkpts:
        print chkpt_name
        test_name = get_test_name(chkpt_name)
        bmark_name = get_bmark_name(test_name)
        skip_amt = get_skip_amt(chkpt_name)
        chkpt_flag = '-f'+os.path.abspath(chkpt_dir+"/"+chkpt_name)
        # Create tests for the specified number of highest weighted checkpoints
        # Add to the test list, the benchmark path, name, skip amt and
        # weight
        test_list.append([bmark_name,test_name,skip_amt,chkpt_flag])
    # Sorth the testlist by bmark name
    test_list = sorted(test_list, key=lambda test: test[0])
    header = ['bmark_name','test_name','skip_amt','chkpt_flag']
    tokens_to_csv('tests_from_checkpoint.csv', test_list, header)
    return test_list_to_testcases(test_list, bmark_bin_prefix)

def create_testcases_from_csv(csv_file, bmark_bin_prefix):
    return test_list_to_testcases(tokenize_csv(csv_file), bmark_bin_prefix)

def main():
    parser = OptionParser(usage="usage: %prog [options] filename",
                          version="%prog 1.0")

    # Simpoints are parsed from subdirectories in this path
    # Directory names are used to extract benchmark names and binary paths
    parser.add_option("-s", "--simpath",
                      action="store",
                      dest="simpoint_path",
                      help="Provide the path where Simpoint folders are. default=None")

    # Simpoints are parsed from subdirectories in this path
    # Directory names are used to extract benchmark names and binary paths
    parser.add_option("-c", "--chkptpath",
                      action="store",
                      dest="checkpoint_path",
                      help="Provide the path where Checkpoints are. default=None")

    # This path is added as a prefix to the benchmark name to deduce the
    # full benchmark binary paths
    parser.add_option("-b", "--binpath",
                      action="store",
                      default="",
                      dest="bmark_bin_path",
                      help="Provide the base path where benahmark binaries are. default=""")

    parser.add_option("-n", "--num_checkpoints",
                      type='int',
                      action="store",
                      dest="num_checkpoints",
                      default=1,
                      help="Pass the number of checkpoints to be created per benchmark. default: 1")

    # Converts testcases in the CSV to the format that Makefile requires
    # and dumps them to the standard output. The standard output is captured
    # in a variable in the Makefile. It can also be captured manually if
    # tweaking is necessary.
    parser.add_option("--csv",
                      action="store",
                      dest="testcase_csv",
                      help="The CSV file containing the testcases in CSV format. default=None")

    (opts, args) = parser.parse_args()

    # Use the absolute path
    if (opts.bmark_bin_path != ""):
        opts.bmark_bin_path = os.path.abspath(opts.bmark_bin_path)+"/"

    if(opts.testcase_csv):
        print create_testcases_from_csv(opts.testcase_csv, opts.bmark_bin_path)

    if(opts.simpoint_path):
        print create_testcases_from_simpoint(opts.simpoint_path, opts.num_checkpoints, opts.bmark_bin_path)

    if(opts.checkpoint_path):
        print create_testcases_from_checkpoint(opts.checkpoint_path, opts.num_checkpoints, opts.bmark_bin_path)


if __name__ == '__main__':
    main()
