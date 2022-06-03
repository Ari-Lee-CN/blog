# props Demo

## <Form/>

* form组件可以被ref获取实例，然后可以调用实例方法submitForm获取表单内容，用于提交表单，resetForm方法用于重置表单
* Form组件自动过滤除了FormItem之外的其他React元素
* FormItem中name属性作为表单提交时候的key，还有展示的label
* FormItem 可以收集<input/>表单中的值

~~~js
export default ()=>{
    const from = React.useRef(null);
    const submit = ()=>{
        //提交表单
        form.current.submitForm(formValue)=>{
            console.log(formValue)
        }
    }
    const reset = ()=>{
        form.current.resetForm()
    }
    return <div className='box'>
        <Form>
}

~~~