#include "RenderingGame.h"
#include "vException.h"
#include "vKeyboard.h"
#include "vMouse.h"
#include "vFpsCounter.h"
#include "vColorHelper.h"
#include "vFPSCamera.h"
#include "vRenderStateHelper.h"
#include "vRasterizerStates.h"
#include "vSamplerStates.h"
#include "vGrid.h"
#include "MaterialDemo.h"
#include "vSkybox.h"
#include "PointLightDemo.h"

#include "DiffuseLightingDemo.h"

namespace Rendering
{
	const XMVECTORF32 RenderingGame::BackgroundColor = ColorHelper::CornflowerBlue;

	RenderingGame::RenderingGame(HINSTANCE instance, const std::wstring& windowClass, const std::wstring& windowTitle, int showCommand)
		: Engine(instance, windowClass, windowTitle, showCommand),
		mFpsComponent(nullptr),
		mDirectInput(nullptr), mKeyboard(nullptr), mMouse(nullptr), mRenderStateHelper(nullptr), mGrid(nullptr),
		mDiffuseLightingDemo(nullptr)
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
		mComponents.push_back(mCamera);
		mServices.AddService(Camera::TypeIdClass(), mCamera);

		mFpsComponent = new FpsCounter(*this);
		mFpsComponent->Initialize();

		mGrid = new Grid(*this, *mCamera);
		mComponents.push_back(mGrid);

		RasterizerStates::Initialize(mDirect3DDevice);
		SamplerStates::BorderColor = ColorHelper::Black;
		SamplerStates::Initialize(mDirect3DDevice);

		mDiffuseLightingDemo = new DiffuseLightingDemo(*this, *mCamera);
		mComponents.push_back(mDiffuseLightingDemo);

		mRenderStateHelper = new RenderStateHelper(*this);

		Engine::Initialize();

		mCamera->SetPosition(0.0f, 0.0f, 25.0f);
	}

	void RenderingGame::Shutdown()
	{
		DeleteObject(mDiffuseLightingDemo);
		DeleteObject(mGrid)
		DeleteObject(mRenderStateHelper);
		DeleteObject(mKeyboard);
		DeleteObject(mMouse);
		DeleteObject(mFpsComponent);
		DeleteObject(mCamera);

		ReleaseObject(mDirectInput);
		RasterizerStates::Release();
		SamplerStates::Release();

		Engine::Shutdown();
	}

	void RenderingGame::Update(const Time &gameTime)
	{
		mFpsComponent->Update(gameTime);

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
		mFpsComponent->Draw(gameTime);
		mRenderStateHelper->RestoreAll();

		HRESULT hr = mSwapChain->Present(0, 0);
		if (FAILED(hr))
		{
			throw Exception("IDXGISwapChain::Present() failed.", hr);
		}
	}
}