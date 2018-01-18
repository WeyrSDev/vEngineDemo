#include "RenderingGame.h"
#include <sstream>
#include <SpriteBatch.h>
#include <SpriteFont.h>
#include "vException.h"
#include "vKeyboard.h"
#include "vMouse.h"
#include "vFpsCounter.h"
#include "vUtility.h"
#include "vColorHelper.h"
#include "vFPSCamera.h"
#include "vPerpspectiveCamera.h"
#include "vOrthographicCamera.h"
#include "vRenderStateHelper.h"
#include "vGrid.h"
#include "Cube.h"
#include "TriangleDemo.h"

namespace Rendering {
	const XMVECTORF32 RenderingGame::BackgroundColor = ColorHelper::CornflowerBlue;

	RenderingGame::RenderingGame(HINSTANCE instance, const std::wstring& windowClass, const std::wstring& windowTitle, int showCommand)
		: Engine(instance, windowClass, windowTitle, showCommand),
		mFpsComponent(nullptr),
		mDirectInput(nullptr), mKeyboard(nullptr), mMouse(nullptr),
		mGrid(nullptr), mRenderStateHelper(nullptr), mDemo(nullptr)
	{
		mDepthStencilBufferEnabled = true;
		mMultiSamplingEnabled = true;
	}

	RenderingGame::~RenderingGame()
	{
	}

	void RenderingGame::Initialize()
	{
		if (FAILED(DirectInput8Create(mInstance, DIRECTINPUT_VERSION, IID_IDirectInput8, (LPVOID*)&mDirectInput, nullptr)))
		{
			throw Exception("DirectInput8Create() failed");
		}

		mKeyboard = new Keyboard(*this, mDirectInput);
		mComponents.push_back(mKeyboard);
		mServices.AddService(Keyboard::TypeIdClass(), mKeyboard);

		mMouse = new Mouse(*this, mDirectInput);
		mComponents.push_back(mMouse);
		mServices.AddService(Mouse::TypeIdClass(), mMouse);

		mCamera = new FPSCamera(*this);
		//mCamera = new PerspectiveCamera(*this);
		//mCamera = new OrthographicCamera(*this);
		mComponents.push_back(mCamera);
		mServices.AddService(Camera::TypeIdClass(), mCamera);

		mFpsComponent = new FpsCounter(*this);
		mComponents.push_back(mFpsComponent);

		mGrid = new Grid(*this, *mCamera);
		mComponents.push_back(mGrid);

		//mDemo = new CubeDemo(*this, *mCamera);
		mDemo = new TriangleDemo(*this, *mCamera);
		mComponents.push_back(mDemo);

		mRenderStateHelper = new RenderStateHelper(*this);
		Engine::Initialize();

		mCamera->SetPosition(0.0f, 0.0f, 10.0f);
	}

	void RenderingGame::Shutdown()
	{
		DeleteObject(mDemo);
		DeleteObject(mRenderStateHelper);
		DeleteObject(mGrid);
		DeleteObject(mKeyboard);
		DeleteObject(mMouse);
		DeleteObject(mFpsComponent);
		DeleteObject(mCamera);

		ReleaseObject(mDirectInput);

		Engine::Shutdown();
	}

	void RenderingGame::Update(const Time &gameTime)
	{
		if (mKeyboard->WasKeyPressedThisFrame(DIK_ESCAPE))
		{
			Exit();
		}

		Engine::Update(gameTime);
	}

	void RenderingGame::Draw(const Time &gameTime)
	{
		mDirect3DDeviceContext->ClearRenderTargetView(mRenderTargetView, reinterpret_cast<const float*>(&BackgroundColor));
		mDirect3DDeviceContext->ClearDepthStencilView(mDepthStencilView, D3D11_CLEAR_DEPTH | D3D11_CLEAR_STENCIL, 1.0f, 0);

		Engine::Draw(gameTime);
		mRenderStateHelper->SaveAll();
		mRenderStateHelper->RestoreAll();
		HRESULT hr = mSwapChain->Present(0, 0);
		if (FAILED(hr))
		{
			throw Exception("IDXGISwapChain::Present() failed.", hr);
		}
	}
}