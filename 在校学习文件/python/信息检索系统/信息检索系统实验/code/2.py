
import os
import codecs
import math
import operator

# 读取txt文件
def read(path):
  f = open(path, encoding="utf8")
  data = []
  for line in f.readlines():
    data.append(line)
  return data

# 按照/切分词表，返回的数值类型是list
def toword(txtlis):
  wordlist = []
  alltxt = ''
  for i in txtlis:
    alltxt = alltxt+str(i)
  ridenter = alltxt.replace('\n', '')
  wordlist = ridenter.split('/')
  return wordlist

# 获取停用词表
def getstopword(path): 
  swlis = []
  for i in read(path):
    outsw = str(i).replace('\n', '')
    swlis.append(outsw)
  return swlis

 # 遍历文件夹中的所有文件，返回文件list
def fun(filepath):
  arr = []
  for root, dirs, files in os.walk(filepath):
    for fn in files:
      arr.append(root+"\\"+fn)
  return arr
 

# 根据停用词表，去除停用词
def getridofsw(lis, swlist):
  afterswlis = []
  for i in lis:
    if str(i) in swlist:
      continue
    else:
      afterswlis.append(str(i))
  return afterswlis
 
 # 统计词频
def freqword(wordlis):
  freword = {}
  for i in wordlis:
    if str(i) in freword:
      count = freword[str(i)]
      freword[str(i)] = count+1
    else:
      freword[str(i)] = 1
  return freword
 
 # 建立相应的语料库
def corpus(filelist, swlist): 
  alllist = []
  for i in filelist:
    afterswlis = getridofsw(toword(read(str(i))), swlist)
    alllist.append(afterswlis)
  return alllist
 
 # 查询文档数
def wordinfilecount(word, corpuslist): 
  count = 0 
  for i in corpuslist:
    for j in i:
      if word in set(j): 
        count = count+1
      else:
        continue
  return count
 
 # 统计TF—IDF的值
def tf_idf(wordlis, filelist, corpuslist): 
  outdic = {}
  tf = 0
  idf = 0
  dic = freqword(wordlis)
  outlis = []
  for i in set(wordlis):
        # 计算TF：某个词在文章中出现的次数/文章总词数
    tf = dic[str(i)]/len(wordlis) 
        # 计算IDF：log(语料库的文档总数/(包含该词的文档数+1))
    idf = math.log(len(filelist)/(wordinfilecount(str(i), corpuslist)+1))
    tfidf = tf*idf 
        # 计算TF-IDF
    outdic[str(i)] = tfidf
        # 排序
  orderdic = sorted(outdic.items(), key=operator.itemgetter(
    1), reverse=True) 
  return orderdic
 
 # 写入前的预处理
def befwry(lis): 
  outall = ''
  for i in lis:
    ech = str(i).replace("('", '').replace("',", '\t').replace(')', '')
    outall = outall+'\t'+ech+'\n'
  return outall

 # 将结果写入txt文件
def wry(txt, path):
  f = codecs.open(path, 'a', 'utf8')
  f.write(txt)
  f.close()
  return path
 
 
def main():
      #停用词表路径
  swpath = r'C:\Users\A\Desktop\信息检索系统实验\中文停用词表.txt'
  swlist = getstopword(swpath) 
      # 获取文件
  filepath = r'C:\Users\A\Desktop\信息检索系统实验\input'
  filelist = fun(filepath) 
      # 输出路径
  wrypath = r'C:\Users\A\Desktop\信息检索系统实验\output.txt'
      # 语料库
  corpuslist = corpus(filelist, swlist) 
 
  outall = ''
 
  for i in filelist:
    afterswlis = getridofsw(toword(read(str(i))), swlist) 
      # 计算TF-IDF值
    tfidfdic = tf_idf(afterswlis, filelist, corpuslist) 
 
    titleary = str(i).split('\\')
    title = str(titleary[-1]).replace('utf8.txt', '')
    echout = title+'\n'+befwry(tfidfdic)
    print(title+' done')
    outall = outall+echout
  print(wry(outall, wrypath)+' done')
 
if __name__ == '__main__':
  main()