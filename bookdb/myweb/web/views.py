from django.shortcuts import render
from django.core.paginator import Paginator
from web.models import Books


# Create your views here.
def index(request):
    # 获取商品信息查询对象
    mod = Books.objects
    list1 = mod.filter()

    # 执行分页处理
    pIndex = int(request.GET.get("p",1))
    page = Paginator(list1, 50)         # 以50条每页创建分页对象
    maxpages = page.num_pages           # 最大页数
    # 判断页数是否越界
    if pIndex > maxpages:
        pIndex = maxpages
    if pIndex < 1:
        pIndex = 1
    list2 = page.page(pIndex) # 当前页数据
    # 获取页面列表信息
    if maxpages < 10:
        plist = page.page_range   # 页码数列表   
    else:
        if pIndex <= 5:
            plist = range(1,10)
        elif pIndex >= maxpages-5:
            plist = range(maxpages-9,maxpages+1)
        else:
            plist = range(pIndex-5,pIndex+5)

    # 封装信息加载模板输出
    context = {"booklist":list2,'plist':plist,'pIndex':pIndex,'maxpages':maxpages}
    return render(request,"web/index.html",context)