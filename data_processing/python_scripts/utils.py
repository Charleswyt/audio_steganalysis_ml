#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Created on 2019.02.14
Finished on 2019.02.14
Modified on 

@author: Yuntao Wang
"""

import os
from glob import glob


def folder_make(path):
    """
    create a folder
    :param path: the path to be created
    :return:
    """
    if not os.path.exists(path) and not os.path.isfile(path):
        os.mkdir(path)
    else:
        pass


def fullfile(file_dir, file_name):
    """
    fullfile as matlab
    :param file_dir: file dir
    :param file_name: file name
    :return:
        full_file_path: the full file path
    """
    full_file_path = os.path.join(file_dir, file_name)
    full_file_path = full_file_path.replace("\\", "/")

    return full_file_path


def get_files_list(file_dir, file_type="txt", start_idx=None, end_idx=None):
    """
    get the files list
    :param file_dir: file directory
    :param file_type: type of files, "*" is to get all files in this folder
    :param start_idx: start index
    :param end_idx: end index
    :return:
        file_list: a list containing full file path
    """
    pattern = "/*." + file_type
    file_list = sorted(glob(file_dir + pattern))
    total_num = len(file_list)
    if type(start_idx) is int and start_idx > total_num:
        start_idx = None
    if type(end_idx) is int and end_idx > total_num:
        end_idx = None
    file_list = file_list[start_idx:end_idx]

    return file_list


def get_file_name(file_path):
    """
    get the name of the file
    :param file_path: the path of the file
    :return:
        the name of the file
    """
    if os.path.exists(file_path):
        file_path_new = file_path.replace("\\", "/")
        file_name = file_path_new.split(sep="/")[-1]

    else:
        file_name = None

    return file_name
